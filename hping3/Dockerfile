FROM ubuntu
LABEL Aleksandr Krasnov "alekforwork@gmail.com"
USER root
RUN apt update && apt install -y hping3 && \
    apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY scan.sh scan.sh
