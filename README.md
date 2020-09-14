# ereefs-python-scripts
[![GitHub license](https://img.shields.io/badge/license-MIT-green)](https://github.com/aims-ks/ereefs-python-scripts/blob/master/LICENSE)

These scripts provide a set of examples for processing eReefs data with Python. 

***

## List of notebooks

When developing scripts there are a number of data sources and services to consider. The most appropriate one depends on your data needs. Since the eReefs models can be extremely large you normally cannot simply download all the data then process it as you like. Typically the aggregate data is used to simply reduce the data to a manageable size. This repository includes a number of Jupyter notebooks that outline how to access the various data sources available from eReefs.

Note: At this stage we only have a few example scripts. More will be added in the future.

| Description | Data source | Notebook |
| -------------| ------- | ------------- |
| 1. Plot AIMS eReefs data as a map from OpeNDAP service | AIMS eReefs aggregate model data | [Notebook (Jupyter)](/notebooks/1-plot-aims-ereefs-map-data.ipynb) |
| 2. Plot AIMS eReefs time plot from OpeNDAP service | AIMS eReefs aggregate model data |[Notebook (Jupyter)](/notebooks/2-plot-aims-ereefs-time-plot.ipynb) |

### Raw CSIRO eReefs model data
After the CSIRO eReefs models are generated they made available publicly on the [NCI THREDDS service](https://dapds00.nci.org.au/thredds/catalogs/fx3/catalog.html). This makes the data available in two formats. You can download the data in [NetCDF](https://www.unidata.ucar.edu/software/netcdf/docs/netcdf_introduction.html) format using HTTPS, which can be done using a web browser or a download script, or you can use the [OpeNDAP](https://docs.opendap.org/index.php/QuickStart) service to access the data dynamically in a programming environment. OpeNDAP allows a program to pull sections of data from the service without downloading all the data first. You can pull data using OpeNDAP using libraries in most programming languages. 

The raw eReefs model data is more complex to process because the model data uses a curvilinear grid, rather an a regular grid. The curviliear grid means that the grid of data is warped so that it is curved to roughly follow the Queensland coastline. This reduces the number of cells that need simuating making the model faster. When using this data to determine the latitude and longitude of a given cell in the data matrix you need to look them up in separate latitude and longitude tables that represent the warping of the grid. Curvilinear grids cannot be processed directly in desktop GIS applications such as ArcGIS or GDAL.

Note: At this stage we don't have any example scripts operating directly off the raw CSIRO eReefs model data.

## AIMS eReefs aggregate model data
The AIMS eReefs platform takes the raw CSIRO eReefs data and generates aggregate data products turning the original hourly data, in curvilinear grid format, into daily, monthly and yearly data on a regular grid. The aggregation reduces the number of time steps in the data, whilst the conversion to a regular grid allows the data to be more easily processed. These derived data products are then made available via a [THREDDS service](http://thredds.ereefs.aims.gov.au/thredds/catalog.html) where you can download the data files in NetCDF format or access them via an OpeNDAP service. 

Note: At this time the AIMS eReefs THREDDS OpeNDAP service only provides access end points for individial NetCDF files, not whole time sequences. As a result the OpeNDAP end points correspond to typically only one month of data. We are working to join all the months of data into a single service that allows you to access any date, not just a month's worth.

## AIMS eReefs data extraction tool time series data
The [AIMS data extraction tool](https://extraction.ereefs.aims.gov.au/) allows users to extract time series data from the raw CSIRO eReefs model data at a set of locations specified by a CSV file. This service operates off the raw model data to provide the highest temporal resolution available. This service also allows the user to perform temporal aggregation on the data if needed. This aggregation then provides summary statistics for each time step.

## Run scripts
The scripts are created as [Jupyter Notebooks](https://jupyter.org/). If you would like to run the notebooks in your
local environment, please refer to [Installing the Jupyter Software](https://jupyter.org/install.html) for more 
information. Alternatively, you can run the scripts in a Docker container with all dependencies automatically installed
as described in the next sections. 

### Run notebook in Docker with Jupyter Lab
This project contains a `Dockerfile` which creates a [Jupyter](https://jupyter.org/) container with Jupyter Lab 
activated, and the necessary libraries installed.

#### Build and start Jupyter in Docker
First we need to call the build command: 
```bash
docker build --tag jupyter .
```
> ***Note***: this can take a while because it installs the netCDF and cartoply libraries. 

After this we can run the container with the following command:

```bash
docker run --rm --name jupyter -d -e JUPYTER_ENABLE_LAB=yes -p 8888:8888 -v "/path/to/ereefs-python-scripts/notebooks":/home/jovyan/work jupyter
``` 
> ***Note***: Please replace "/path/to/ereefs-python-scripts/notebooks" with your local path to the `notebooks` directory
>in this repository.

Once the Docker container is running Jupyter Lab can be accessed via `http://localhost:8888` (see 
https://jupyter-docker-stacks.readthedocs.io/en/latest/using/running.html for more information).

When accessing the Jupyter Lab for the first time it asks for an access token. This can be retrieved by running:

```bash
docker logs jupyter
```

After the login you can open the notebooks by going into the sub-folder `work`.
