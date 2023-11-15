# eReefs Data Access and Visualisation Examples

This repository contains Jupyter notebooks which are working examples
of ways to work with eReefs datasets using Python.

All of the datasets are queried via HTTP(s) from the data services
they are published in:  you do *not* need to download any of the eReefs
data files to your local environment to make these work.

Many of the examples depend on the [emsarray](https://emsarray.readthedocs.io/) library, which is an open-source library that assists Python developers to work with the results of [CSIRO EMS](https://github.com/csiro-coasts/ems/) models like eReefs GBR4, GBR1 and RECOM model results.

- [Notebooks Directory](#notebooks-directory)
  - [Discovering eReefs Datasets (data-discovery.ipynb)](#discovering-ereefs-datasets-data-discoveryipynb)
  - [Discovering eReefs dataset dimensions (dataset-dimentions.ipynb)](#discovering-ereefs-dataset-dimensions-dataset-dimentionsipynb)
  - [Plotting eReefs model results with matplotlib (plot.ipynb)](#plotting-ereefs-model-results-with-matplotlib-plotipynb)
  - [Plotting eReefs model results with bokeh (bokeh.ipynb)](#plotting-ereefs-model-results-with-bokeh-bokehipynb)
  - [Clipping eReefs datasets (clip.ipynb)](#clipping-ereefs-datasets-clipipynb)
  - [Plotting eReefs transects (transect.ipynb)](#plotting-ereefs-transects-transectipynb)
  - [Animating eReefs model results (animation.ipynb)](#animating-ereefs-model-results-animationipynb)
    - [Simulated true colour from eReefs optical model variables (true-colour.ipynb)](#simulated-true-colour-from-ereefs-optical-model-variables-true-colouripynb)
- [How to run these notebooks](#how-to-run-these-notebooks)
  - [Use the ARDC's Jupyter Notebook Service](#use-the-ardcs-jupyter-notebook-service)
  - [Run a local Jupyter-Lite docker container](#run-a-local-jupyter-lite-docker-container)

---

## Notebooks Directory

### Discovering eReefs Datasets (data-discovery.ipynb)

[data-discovery.ipynb](./data-discovery.ipynb)

This notebook is more like documentation...

It explains how to identify the OPeNDAP endpoint URL for any eReefs netCDF dataset using the CSIRO eReefs Data Explorer.  URLs of this type are using in most of the other notebooks in the suite.

&nbsp;

### Discovering eReefs dataset dimensions (dataset-dimentions.ipynb)

[dataset-dimensions.ipynb](./dataset-dimensions.ipynb)

This notebook demonstrates how to extract information about the spatial and temporal dimensions of an eReefs dataset.

&nbsp;

### Plotting eReefs model results with matplotlib (plot.ipynb)

[plot.ipynb](./plot.ipynb)

This notebook shows the basics of using `emsarray` and `matplotlib` to plot variables extracted from eReefs datasets on a map.

It is adapted from the [similar example in the `emsarray-notebooks` repository](hhttps://github.com/csiro-coasts/emsarray-notebooks/blob/master/plot.ipynb).

&nbsp;

### Plotting eReefs model results with bokeh (bokeh.ipynb)

[bokeh.ipynb](./bokeh.ipynb)

This notebook also plots eReefs data on a map, but uses the popular `bokeh`
library to do so.

It is adapted from the [similar example in the `emsarray-notebooks` repository](hhttps://github.com/csiro-coasts/emsarray-notebooks/blob/master/bokeh.ipynb).

&nbsp;

### Clipping eReefs datasets (clip.ipynb)

[clip.ipynb](./clip.ipynb)

This notebook shows how to use `emsarray` to extract a spatial subset of a large eReefs dataset, that is then plotted on a map using `matplotlib`.

It is adapted from the [similar example in the `emsarray-notebooks` repository](hhttps://github.com/csiro-coasts/emsarray-notebooks/blob/master/clip.ipynb).

&nbsp;

### Plotting eReefs transects (transect.ipynb)

[transect.ipynb](./transect.ipynb)

This notebook shows how to extract values from an eReefs dataset along a predefined spatial transect, either as a line chart for a single elevation, or as a vertical cross-section of the model results.

It is adapted from the [similar example in the `emsarray-notebooks` repository](hhttps://github.com/csiro-coasts/emsarray-notebooks/blob/master/transect.ipynb).

&nbsp;

### Animating eReefs model results (animation.ipynb)

[animation.ipynb](./animation.ipynb)

This notebook demonstrates how to use emsarray to render animations of eReefs dataset variables. The animations can be across time, or across another axis such as depth.

It is adapted from the [similar example in the `emsarray-notebooks` repository](hhttps://github.com/csiro-coasts/emsarray-notebooks/blob/master/animation.ipynb).

&nbsp;

#### Simulated true colour from eReefs optical model variables (true-colour.ipynb)

This notebook shows how to combine simulated remote sensing reflctance variables from an eReefs Biogeochemistry and Sediments dataset to create a simulated true-colour image of the GBR. The resulting image simulates what remote sensing observations of the GBR might look like to the Ocean and Land Colour Instrument (OLCI) on the Sentinel-3A or Sentinel-3B satellites.

[true-colour.ipynb](./true-colour.ipynb)

&nbsp;

---

## How to run these notebooks

### Use the ARDC's Jupyter Notebook Service

If you are affiliated with an Australian eResearch agency and have an
Australian Access Federation account, you can use the
[ARDC Jupyter Notebook service](https://ardc.edu.au/services/ardc-nectar-research-cloud/ardc-jupyter-notebook-service/)
to launch these notebooks.

- log in to the service at <https://jupyterhub.rc.nectar.org.au/> with your AAF credentials.
- Choose the `SciPy` notebook environment
- In the launcher page, select the `terminal` application to launch.
- In the terminal, run:

  ```bash
  # Clone the notebooks repository
  mkdir notebooks
  cd notebooks
  git clone https://github.com/eReefs/ereefs-data-access-notebooks.git .

  # Install dependencies into a conda environment (this can be slow!)
  conda env create --name notebooks --file ./environment.yaml

  # Make that conda environment be loaded by any new ipynb kernels:
  python -m ipykernel install --user --name notebooks –display-name 'eReefs notebooks'
  ```

- You should now be able to browse to all the notebooks in the `notebooks`
  folder in the sidebar, and they should be able to find the libraries they need.

  If you run into errors related to dependencies, click the kernel name on the
  top-right of the notebook page and select the 'eReefs notebooks' kernel.


### Run a local Jupyter-Lite docker container

This works well for development and debugging of the notebooks.

```bash
# Clone a working copy of the repository
git clone git@github.com:eReefs/ereefs-data-access-notebooks.git
cd ereefs-data-access-notebooks

# Build the local Jupyter-Lite server
docker compose build

# Launch the Jupter-Lite server
docker compose up
```

Watch the standard output for the server as it launches - that will
tell you the URL that you can navigate to in your browser to run the
notebooks, which will look something like
<http://127.0.0.1:8888/lab?token=some-access-token>

The notebooks will be available at the 'notebooks' subdirectory in the
navigation sidebar.  They are bind-mounted from your working clone
of the git repository, so you should be able to make edits in the repository
and see them in the browser and vice-versa.

&nbsp;
