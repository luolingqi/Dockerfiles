FROM rocker/shiny:4.1.0

LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.source="https://github.com/rocker-org/rocker-versioned2" \
      org.opencontainers.image.vendor="Rocker Project" \
      org.opencontainers.image.authors="Carl Boettiger <cboettig@ropensci.org>"

RUN /rocker_scripts/install_tidyverse.sh

RUN apt-get update && apt-get install -y libglpk-dev

RUN mkdir -p /var/lib/shiny-server/bookmarks/luolingq

RUN R -e "remotes::install_github('HenrikBengtsson/matrixStats', ref='develop')"

RUN R -e "BiocManager::install(version='3.14', ask=F)"
RUN R -e "BiocManager::install('GeomxTools', ask=F)"

COPY shiny-server.sh /usr/bin
COPY shiny-server.conf /etc/shiny-server

