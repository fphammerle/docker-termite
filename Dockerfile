FROM debian:buster-slim as build

RUN apt-get update && apt-get install --yes --no-install-recommends \
    git \
    gperf \
    gtk-doc-tools \
    intltool \
    libgirepository1.0-dev \
    libgnutls28-dev \
    libgtk-3-dev \
    libpcre2-dev \
    libtool-bin \
    libxml2-utils \
    valac

# TODO clone and build as unprivileged user

ARG VTE_NE_VERSION=0.50.2-ng
RUN git clone --branch "$VTE_NE_VERSION" https://github.com/thestinger/vte-ng.git /vte-ng
WORKDIR /vte-ng
RUN ./autogen.sh && make && make install && ldconfig

ARG TERMITE_VERSION=v15
RUN git clone --recursive --branch "$TERMITE_VERSION" https://github.com/thestinger/termite.git /termite
WORKDIR /termite
RUN make && make install

WORKDIR /
CMD ["/usr/local/bin/termite"]
