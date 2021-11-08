FROM ubuntu




RUN /rocker_scripts/install_tidyverse.sh

RUN apt-get update && apt-get install -y libglpk-dev

RUN mkdir -p /var/lib/shiny-server/bookmarks/luolingq
RUN R -e "remotes::install_github('HenrikBengtsson/matrixStats', ref='develop')"
RUN R -e "install.packages('Seurat')"
RUN R -e "BiocManager::install('bluster')"
RUN R -e "BiocManager::install('DropletUtils')"
RUN R -e "BiocManager::install('scater')"
RUN R -e "BiocManager::install('scran')"

RUN install2.r pheatmap DT shinydashboard shinythemes shinyjs

COPY shiny-server.sh /usr/bin
COPY shiny-server.conf /etc/shiny-server
