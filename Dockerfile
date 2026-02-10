FROM continuumio/miniconda3:latest

# Update OS packages
# Update all pre-installed OS packages, and add a few extra utilities
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install --no-install-recommends -y \
        curl \
        ffmpeg \
        gnupg2 \
    && apt-get clean \
    && apt-get autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "--login", "-c"]
ENV PYTHONDONTWRITEBYTECODE=true

# Update the base conda environment and make sure it does NOT
# use the 'defaults' channel, which requires a paid subscription
RUN conda init bash \
    && conda config --remove channels defaults \
    && conda config --add channels conda-forge \
    && conda update --yes --name base \
        --channel conda-forge --override-channels \
        conda

# Install the Jupyter lab server in the base environment
RUN conda activate base \
    && conda install --yes \
        --channel conda-forge --override-channels \
        jupyterlab

# Prepare a dedicated conda environment and ipykernel for the eReefs notebooks dependencies
WORKDIR /opt/ereefs
COPY ./requirements ./requirements
RUN conda env create --name ereefs --file ./requirements/conda-linux-64.lock

# Install all the notebook files from this repository
COPY ./ ./

# Create a non-root runtime user account to own the installed notebook files
# The uid and gid for this user can be controlled via build arguments to match
# your own uid/gid if you intend to bind-mount the notebook files for editing
# when you launch the resulting container.
# (The username can also be controlled, but that is mostly cosmetic)
ARG RUN_GID=1001 \
    RUN_UID=1001\
    RUN_USER=jupyter
RUN groupadd -g ${RUN_GID} ${RUN_USER} \
    && useradd ${RUN_USER} -u ${RUN_UID} -g ${RUN_GID} --create-home --no-log-init --shell "/bin/bash" \
    && chown -R ${RUN_UID}:${RUN_GID} /opt/ereefs

# Create a tmpdir volume mount and some symlinks to ensure conda and jupyter don't
# write too many extra files into the container's  overlay filesystem at runtime
VOLUME [ "/tmp" ]
RUN chmod 2777 /tmp \
    && for DIRNAME in .cache .conda .config .ipython .jupyter .local; do \
      mkdir -p "/tmp/${DIRNAME}"; \
      chown -R ${RUN_UID}:${RUN_GID} "/tmp/${DIRNAME}"; \
      ln -sf "/tmp/${DIRNAME}" "/home/${RUN_USER}/${DIRNAME}"; \
    done

# Remove the default Jupyter kernel from the list of options
RUN conda activate base \
    && jupyter kernelspec remove -y python3

# Run the Jupyter Lab server as the runtime user at launch,
# with the eReefs conda environment set up as the default kernel
USER ${RUN_USER}
RUN conda init bash \
    && echo "conda activate base" >> ~/.bashrc \
    && echo "conda info --envs" >> ~/.bashrc \
    && echo "which jupter" >> ~/.bashrc \
    && echo "jupyter kernelspec list" >> ~/.bashrc
RUN conda activate ereefs \
    && python -m ipykernel install --user --name ereefs --display-name 'eReefs' \
    && conda deactivate


ENTRYPOINT ["jupyter"]
CMD [ \
    "lab", \
    "--KernelSpecManager.ensure_native_kernel=False", \
    "--notebook-dir=/opt/ereefs", \
    "--ip=*", \
    "--port=8888", \
    "--no-browser" \
]
