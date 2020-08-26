# ereefs-python-scripts
[![GitHub license](https://img.shields.io/badge/license-MIT-green)](https://github.com/aims-ks/ereefs-python-scripts/blob/master/LICENSE)

Example scripts for processing AIMS eReefs derived data with Python.

***

List of notebooks:

| Description | Notebook |
| ------------- | ------------- |
| 1. Plot AIMS eReefs data | [Notebook (Jupyter)](/notebooks/1-plot-aims-ereefs-data.ipynb) |


## Run notebook in Docker with Jupyter Lab
This project contains a `Dockerfile` which creates a [Jupyter](https://jupyter.org/) container with Jupyter Lab 
activated, and the necessary libraries installed.

### Build and start Jupyter in Docker
First we need to call the build command: 
```bash
docker build --tag jupyter .
```
> ***Note***: this can take a while because it installs the netCDF and cartoply libraries. 

After this we can run the container with the following command:

```bash
docker run --rm --name jupyter -d \
    -e JUPYTER_ENABLE_LAB=yes \
    -p 8888:8888 \
    -v /path/to/ereefs-python-scripts/notebooks:/home/jovyan/work jupyter
``` 
Once the Docker container is running Jupyter Lab can be accessed via `http://localhost:8888` (see 
https://jupyter-docker-stacks.readthedocs.io/en/latest/using/running.html for more information).

When accessing the Jupyter Lab for the first time it asks for an access token. This can be retrieved by running:

```bash
docker logs jupyter
```

After the login you can open the notebooks by going into the sub-folder `work`.
