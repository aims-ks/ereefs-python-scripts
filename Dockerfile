FROM jupyter/scipy-notebook:b2562c469cdd

RUN conda install -c conda-forge netcdf4
RUN conda install -c conda-forge cartopy

# Download some NaturalEarth data for cartopy
ENV CARTOPY_DIR=/home/jovyan/.cartopy-data
ENV NE_PHYSICAL=${CARTOPY_DIR}/shapefiles/natural_earth/physical
RUN mkdir -p ${NE_PHYSICAL}
RUN wget https://naturalearth.s3.amazonaws.com/50m_physical/ne_50m_coastline.zip -P ${CARTOPY_DIR}
RUN unzip ${CARTOPY_DIR}/ne_50m_coastline.zip -d  ${NE_PHYSICAL}
RUN rm ${CARTOPY_DIR}/*.zip
