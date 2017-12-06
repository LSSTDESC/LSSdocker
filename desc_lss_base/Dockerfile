## build with
## docker build -t desc_lss_base .
##

FROM ubuntu:16.04

## we need full build env for MPI built
RUN apt-get update && apt-get install -y autoconf automake gcc g++ gfortran make wget \
                git libgsl-dev libcfitsio-dev libtool libhdf5-dev \
		screen emacs-nox && apt-get clean all

## get anaconda
RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-5.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENV PATH /opt/conda/bin:$PATH

## build mpi4py
RUN mkdir /build/
RUN cd /build && wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz \
  && tar xvzf mpich-3.2.tar.gz && cd /build/mpich-3.2 \
  && ./configure && make -j4 && make install && make clean && rm /build/mpich-3.2.tar.gz

RUN cd /build && wget https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-3.0.0.tar.gz \
  && tar xvzf mpi4py-3.0.0.tar.gz
RUN cd /build/mpi4py-3.0.0 && python setup.py build && python setup.py install && rm -rf /build/
RUN /sbin/ldconfig

## insteall healpy
RUN pip install healpy

## add user
RUN useradd -ms /bin/bash lss

WORKDIR /home/lss
## stage files, to prevent redownload every time we're building docker
RUN git clone https://github.com/hyperrealm/libconfig.git
RUN wget http://www.fftw.org/fftw-3.3.7.tar.gz
RUN wget https://downloads.sourceforge.net/project/healpix/Healpix_3.31/Healpix_3.31_2016Aug26.tar.gz
RUN git clone https://github.com/Libsharp/libsharp.git
## and our scripts
COPY install-libs.sh .
COPY install-software.sh .
COPY scripts/Makefile.CoLoRe .
COPY scripts/runCoLoRe .
RUN chown -R lss *
USER lss

RUN bash /home/lss/install-libs.sh
RUN bash /home/lss/install-software.sh
