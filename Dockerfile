# ================================================
# DOCKERFILE =====================================
# ================================================
FROM ufoym/deepo:all-py36-jupyter

# ------------------------------------------------
# PACKAGES ---------------------------------------
# ------------------------------------------------
RUN apt-get update
RUN apt-get install -y nodejs apt-utils

# ------------------------------------------------
# JUPYTER-LAB ------------------------------------
# ------------------------------------------------
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    $PIP_INSTALL \
        jupyterlab \
        && \
        jupyter serverextension enable --py jupyterlab && \
        mkdir -p /opt/app/data

# Copy Jupyter config
# ------------------------------------------------
COPY ./docker/jupyter_notebook_config.py /root/.jupyter/

# Copy run script
# ------------------------------------------------
COPY ./docker/run_jupyter.sh /root/

# ------------------------------------------------
# INSTALL-FROM-CONFIG ----------------------------
# ------------------------------------------------
COPY ./docker/install_from_config.py /root/

ADD ./config/ /root/config

RUN python /root/install_from_config.py

