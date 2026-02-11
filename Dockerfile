# NOTE: binderhub requires an image tag be used here which is NOT 'latest'
FROM continuumio/miniconda3:v25.11.1

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

# Install the Jupyter lab and notebook servers in the base environment
RUN conda activate base \
    && conda install --yes \
        --channel conda-forge --override-channels \
        jupyterlab notebook

# Create a non-root runtime user account.
# The uid and gid for this user default to 1000:1000 for binderhub compatibility,
# but can also be controlled via build arguments to match your own uid/gid if you
# intend to bind-mount the notebook files for editing at runtime.
# (The username can also be controlled, but that is mostly cosmetic)
ARG RUN_GID=1000 \
    RUN_UID=1000 \
    RUN_USER=jovyan

RUN groupadd -g ${RUN_GID} ${RUN_USER} \
    && useradd ${RUN_USER} -u ${RUN_UID} -g ${RUN_GID} \
        --create-home \
        --no-log-init \
        --shell "/bin/bash"

# Create a working directory *inside* the runtime user's
# home directory where we will put all our custom content.
WORKDIR "/home/${RUN_USER}/ereefs"

# Prepare a custom conda environment that includes our notebooks' dependencies
COPY ./requirements ./requirements
RUN conda env create --name ereefs --file ./requirements/conda-linux-64.lock

# Remove the default 'python3' kernel so that the eReefs one becomes the default.
RUN conda activate base \
    && jupyter kernelspec remove -y python3 \
    && conda deactivate

# Install all the remaining files not listed in the .dockerignore file from
# this repository, then *remove* the requirements folder so it doesn't clutter
# up the binderhub interface.
COPY ./ ./
RUN rm -r ./requirements \
    && chown -R ${RUN_UID}:${RUN_GID} . \
    && find ./ -type d -print0 | xargs --no-run-if-empty -0 chmod g+rwx,o+rx \
    && find ./ -type f -print0 | xargs --no-run-if-empty -0 chmod g+rw,o+r

# Switch to the runtime user identity, and set up the eReefs conda environment
# to be the default Jupyter kernel when the server is launched.
USER ${RUN_USER}
RUN conda init bash \
    && conda activate ereefs \
    && python -m ipykernel install --user --name ereefs --display-name 'eReefs' \
    && conda deactivate \
    && echo "conda activate base" >> ~/.bashrc \
    && echo "conda info --envs" >> ~/.bashrc \
    && echo "which jupter" >> ~/.bashrc \
    && echo "jupyter kernelspec list" >> ~/.bashrc

#  Run the full Jupyter Lab server at launch by default.
ENTRYPOINT []
CMD [ "jupyter", "lab", \
    "--KernelSpecManager.ensure_native_kernel=False", \
    "--ip=*", \
    "--port=8888", \
    "--no-browser" \
]
