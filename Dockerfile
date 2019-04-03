FROM ubuntu
LABEL Aleksandr Krasnov "alekforwork@gmail.com"
USER root
RUN apt-get update && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY humptydumpty.sh humptydumpty.sh
COPY art/ art/