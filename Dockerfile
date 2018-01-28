FROM jupyter/r-notebook

EXPOSE 8080
EXPOSE 8888

USER root

RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

USER jovyan

RUN bash -c "pip install --no-cache-dir \
virtualenv \
ipyleaflet \
bqplot \
jupyter_contrib_nbextensions \
jupyter_nbextensions_configurator && \
jupyter nbextension enable --py --sys-prefix ipyleaflet && \
jupyter nbextensions_configurator enable --user \
"

ADD requirements.txt /home/jovyan/work/requirements.txt
RUN bash -c "pip install --no-cache-dir -r /home/jovyan/work/requirements.txt"
