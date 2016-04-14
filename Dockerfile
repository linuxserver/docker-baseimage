FROM ubuntu:14.04
MAINTAINER lonix
ENV HOME="/root" TERM="xterm"
ENTRYPOINT ["/init"]
COPY root /
ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get install -y curl python-bs4 git-core && \
useradd -u 911 -U -d /config -s /bin/false abc && \
usermod -G users abc && \
curl -L https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz | tar xvz -C / && \
mkdir -p /usr/local/bin/aptselect.d && curl -L https://github.com/jblakeman/apt-select/archive/v0.1.1.tar.gz | tar xvz -C /usr/local/bin/aptselect.d --strip-components=1 && \
ln -s /usr/local/bin/aptselect.d/apt-select.py /usr/local/bin/apt-select && \
apt-get clean && rm -rfv /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/init"]
