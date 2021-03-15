FROM rocker/rstudio:latest

RUN apt-get update && apt-get install -y libxml2-dev

RUN install2.r --error \
    tidyverse \
    stringr \
    knitr \
    magrittr

RUN install2.r --error \
    RColorBrewer

