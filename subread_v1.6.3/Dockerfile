############################################################ 
# Dockerfile to build subread-1.6.3 container images 
# Based on Ubuntu  
# Set the base image to r-base:3.5.2 
############################################################

FROM r-base:3.5.2

# Install compiler 

RUN apt-get update --fix-missing\
    && apt-get install -y \
        build-essential \
        gcc-multilib \
        apt-utils \
        zlib1g-dev \
        libxml2-dev \
        curl \
        libncurses5-dev
        
      
# Install subread 
WORKDIR /usr/local/ 
RUN wget "https://downloads.sourceforge.net/project/subread/subread-1.6.3/subread-1.6.3-source.tar.gz"
RUN ls | grep subread
RUN tar -xzvf subread-1.6.3-source.tar.gz
WORKDIR /usr/local/subread-1.6.3-source/src 
RUN make -f Makefile.Linux 
RUN ln -s /usr/local/subread-1.6.3-source/bin/* /usr/local/bin


# Cleanup
RUN apt-get clean

# Default command to execute at startup of the container
CMD cd /home/
