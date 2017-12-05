FROM ubuntu:16.04
RUN apt-get update && apt-get install -y autoconf automake gcc g++ make gfortran wget && apt-get clean all

## build python and mpi4py
RUN mkdir /build/
RUN cd /build && wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz \
  && tar xvzf Python-2.7.13.tgz && cd /build/Python-2.7.13 \
  && ./configure && make -j4 && make install && make clean && rm /build/Python-2.7.13.tgz
RUN cd /build && wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz \
  && tar xvzf mpich-3.2.tar.gz && cd /build/mpich-3.2 \
  && ./configure && make -j4 && make install && make clean && rm /build/mpich-3.2.tar.gz

RUN cd /build && wget https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-2.0.0.tar.gz \
  && tar xvzf mpi4py-2.0.0.tar.gz
RUN cd /build/mpi4py-2.0.0 && python setup.py build && python setup.py install && rm -rf /build/
RUN /sbin/ldconfig

## add required tools
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y libgsl-dev
RUN apt-get install -y libcfitsio-dev
RUN apt-get install -y libtool

## add user
RUN useradd -ms /bin/bash lss

WORKDIR /home/lss
COPY scripts/* /home/lss/
COPY install.sh .
RUN chown lss *
USER lss

RUN bash /home/lss/install.sh

## clean up
USER root
RUN apt-get remove -y git

