# eReefs Data Access and Visualisation Examples

This repository contains Jupyter notebooks which are working examples
of ways to work with eReefs datasets using Python.

All of the datasets are queried via HTTP(s) from the data services
they are published in:  you do *not* need to download any of the eReefs
data files to your local environment to make these work.

- [Notebooks Directory](#notebooks-directory)
  - [Examples that use the emsarray library](#examples-that-use-the-emsarray-library)
    - [plot.ipynb](#plotipynb)
    - [clip.ipynb](#clipipynb)
    - [bokeh.ipynb](#bokehipynb)
    - [transect.ipynb](#transectipynb)
    - [animation.ipynb](#animationipynb)
  - [Examples that use the eReefs netCDF Web Processing Service](#examples-that-use-the-ereefs-netcdf-web-processing-service)
    - [simpledpn.ipynb](#simpledpnipynb)
    - [truecolour.ipynb](#truecolouripynb)
- [How to run these notebooks](#how-to-run-these-notebooks)
  - [Use the ARDC's Jupyter Notebook Service](#use-the-ardcs-jupyter-notebook-service)
  - [Run a local Jupyter-Lite docker container](#run-a-local-jupyter-lite-docker-container)

---

## Notebooks Directory

### Examples that use the emsarray library

[emsarray](https://emsarray.readthedocs.io/) is an open-source library that assists Python developers to work with the results of [CSIRO EMS](https://github.com/csiro-coasts/ems/) models like eReefs GBR4, GBR1 and RECOM model results, and
also other CF-compliant gridded netCDF data.

These examples are adapted from similar ones in the [emsarray-notebooks](https://github.com/csiro-coasts/emsarray-notebooks/tree/master) repository, but have been re-worked to use eReefs datasets directly from their data provider nodes.

#### [plot.ipynb](./plot.ipynb)

This notebook shows the basics of using `emsarray` to plot variables extracted from eReefs datasets on a map. It uses the `cartopy` and `matplotlib` libraries.

#### [clip.ipynb](./clip.ipynb)

This notebook shows how to use `emsarray` to extract a spatial subset of a large eReefs dataset, that is then plotted on a map using `matplotlib`.

#### [bokeh.ipynb](./bokeh.ipynb)

This notebook also plots eReefs data on a map, but uses the popular `bokeh`
library to do so rather than `matplotlib`.

#### [transect.ipynb](./transect.ipynb)

This notebook shows how to extract values from an eReefs dataset along a known spatial transect and display those on a transect plot.

#### [animation.ipynb](./animation.ipynb)

This notebook demonstrates how to use emsarray to render animations of eReefs dataset variablesome simple animations that emsarray can generate. The animations can be across time, or across another axis such as depth.

&nbsp;

### Examples that use the eReefs netCDF Web Processing Service

One of the applications we host as part of the eReefs platform is a netCDF Web Processing service which allows you to request some standard eReefs visualisations via a single HTTP Query: the [CSIRO eReefs Visportal](https://portal.ereefs.info) makes heavy use of that service to render plots and animations of data.

These examples show how to invoke that service.

#### [simpledpn.ipynb](./NCWPSExamples/simpledpn.ipynb)

Invoke the eReefs ncWPS to retrieve information about eReefs dataset dimensions.

#### [truecolour.ipynb](./NCWPSExamples/truecolour.ipynb)

Invoke the eReefs ncWPS to combine the reflectance variables from an eReefs Biogeochemistry and Sediments dataset into a simulated true colour image.

This image simulates what remote sensing observations of the GBR might look like
to a satellite like the Sentinel-3 Ocean and Land Colour Instrument. (OLCI)

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
