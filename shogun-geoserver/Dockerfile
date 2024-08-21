FROM docker.osgeo.org/geoserver:2.25.3

ARG USER_UID
ARG USER_GID
ARG USER_NAME

RUN groupadd -g $USER_GID -o $USER_NAME
RUN useradd -ou $USER_UID -g $USER_GID -s /bin/bash $USER_NAME
RUN usermod -aG sudo $USER_NAME

RUN chown -R $USER_NAME:$USER_NAME $CATALINA_HOME

EXPOSE 8080

USER $USER_NAME
