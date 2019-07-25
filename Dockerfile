FROM debian:buster-slim

RUN apt-get update && apt-get install --yes --no-install-recommends \
    gperf \
    gtk-doc-tools \
    intltool \
    libgirepository1.0-dev \
    libgnutls28-dev \
    libxml2-utils \
    valac
RUN apt-get update && apt-get install --yes --no-install-recommends git
RUN apt-get update && apt-get install --yes --no-install-recommends libtool-bin

ARG VTE_NE_VERSION=0.50.2-ng
RUN git clone --branch "$VTE_NE_VERSION" https://github.com/thestinger/vte-ng.git /vte-ng

RUN apt-get update && apt-get install --yes --no-install-recommends libgtk-3-dev libpcre2-dev

WORKDIR /vte-ng
RUN ./autogen.sh
RUN make
RUN make install

ARG TERMITE_VERSION=v15
RUN git clone --recursive --branch "$TERMITE_VERSION" https://github.com/thestinger/termite.git /termite
WORKDIR /termite
RUN make
RUN make install

RUN ldconfig

CMD ["/usr/local/bin/termite"]
