docker run --rm --name jupyter -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "%CD%:/home/jovyan/work" jupyter
pause > nul