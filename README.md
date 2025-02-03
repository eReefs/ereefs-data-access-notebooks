# eReefs Data Access and Visualisation Examples

This repository contains Jupyter notebooks which are working examples
of ways to work with eReefs datasets using Python.

All of the datasets are queried via HTTP(s) from the data services
they are published in:  you do *not* need to download any of the eReefs
data files to your local environment to make these work.

Many of the examples depend on the [emsarray](https://emsarray.readthedocs.io/) library, which is an open-source library that assists Python developers to work with the results of [CSIRO EMS](https://github.com/csiro-coasts/ems/) models like eReefs GBR4, GBR1 and RECOM model results.

- [How to run these notebooks](#how-to-run-these-notebooks)
  - [Use the ARDC's Jupyter Notebook Service](#use-the-ardcs-jupyter-notebook-service)
  - [Run a local Jupyter-Lite docker container](#run-a-local-jupyter-lite-docker-container)
- [Notebooks Directory](#notebooks-directory)
  - [Discovering eReefs Datasets (data-discovery.ipynb)](#discovering-ereefs-datasets-data-discoveryipynb)
  - [Discovering eReefs dataset dimensions (dataset-dimentions.ipynb)](#discovering-ereefs-dataset-dimensions-dataset-dimentionsipynb)
  - [Extracting a timeseries from eReefs model results (timeseries.ipynb)](#extracting-a-timeseries-from-ereefs-model-results-timeseriesipynb)
  - [Plotting eReefs model results with matplotlib (plot.ipynb)](#plotting-ereefs-model-results-with-matplotlib-plotipynb)
  - [Plotting eReefs model results with bokeh (bokeh.ipynb)](#plotting-ereefs-model-results-with-bokeh-bokehipynb)
  - [Clipping eReefs datasets (clip.ipynb)](#clipping-ereefs-datasets-clipipynb)
  - [Plotting eReefs transects (transect.ipynb)](#plotting-ereefs-transects-transectipynb)
  - [Animating eReefs model results (animation.ipynb)](#animating-ereefs-model-results-animationipynb)
  - [Simulated true colour from eReefs optical model variables (true-colour.ipynb)](#simulated-true-colour-from-ereefs-optical-model-variables-true-colouripynb)

---

## How to run these notebooks

### Launch on Binder

Binder is an online platform that can set up an environment and run Jupyter Lab in your browser.
[Launch the eReefs data access notebooks on Binder](https://mybinder.org/v2/gh/eReefs/ereefs-data-access-notebooks/HEAD).

### Run Jupyter Lab in a local conda environment.

This will run the Jupyter Lab server on your local computer in a Conda environment.
First [install miniconda](https://docs.anaconda.com/miniconda/install/)
if you do not already have a Conda install.
Then clone this repository:

```bash
$ git clone git@github.com:eReefs/ereefs-data-access-notebooks.git
$ cd ereefs-data-access-notebooks
```

Create a new conda environment:

```bash
$ conda env create --name ereefs-data-access-notebooks --file environment.yaml
```

Finally, activate the conda environment and run Jupyter Lab:

```bash
$ conda activate --name ereefs-data-access-notebooks
$ jupyter-lab
```

The Jupyter Lab interface should open in your browser.
From here you can open, edit, and run any of the notebooks in this repository.

&nbsp;

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

### Extracting a timeseries from eReefs model results (timeseries.ipynb)

[timeseries.ipynb](./timeseries.ipynb)

This notebook demonstrates how to extract a timeseries of variable values for spatial locations within an eReefs dataset.

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

### Simulated true colour from eReefs optical model variables (true-colour.ipynb)

This notebook shows how to combine simulated remote sensing reflctance variables from an eReefs Biogeochemistry and Sediments dataset to create a simulated true-colour image of the GBR. The resulting image simulates what remote sensing observations of the GBR might look like to the Ocean and Land Colour Instrument (OLCI) on the Sentinel-3A or Sentinel-3B satellites.

[true-colour.ipynb](./true-colour.ipynb)

&nbsp;

---
