FROM ubuntu:latest
LABEL Aleksandr Krasnov "alekforwork@gmail.com"
USER root
RUN apt-get update && apt-get upgrade -y  && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY humptydumpty.sh humptydumpty.sh
