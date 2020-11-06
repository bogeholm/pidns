FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install --no-install-recommends --yes \
    systemd \
    curl \
    ca-certificates

RUN echo "$(systemctl --version)"

WORKDIR /home/ubuntu
COPY . ./

RUN bash download.sh -a "linux-amd64"
RUN bash install.sh
