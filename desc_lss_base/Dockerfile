## build with
## docker build -t desc_lss_base .
##

FROM ubuntu:latest

## we need full build env
RUN apt-get update && apt-get install -y autoconf automake gcc g++ gfortran make wget \
                git libgsl-dev libcfitsio-dev libtool libhdf5-dev \
		screen emacs-nox curl grep sed dpkg  python && \
		DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libffi-dev \
		python-pip && \
		rm -rf /var/lib/apt/lists/* 
#  install MPI, install mpi4py, install python prereq, add lss user
RUN 		mkdir /build/ && \
		cd /build && wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz && \
		tar xvzf mpich-3.2.tar.gz && cd /build/mpich-3.2 && \
		./configure && \
		make -j4 && \
		make install && \
		make clean && \
		rm /build/mpich-3.2.tar.gz && \
		cd /build && wget https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-3.0.0.tar.gz && \
  		tar xvzf mpi4py-3.0.0.tar.gz  && \
 		cd /build/mpi4py-3.0.0 && \
		python setup.py build && python setup.py install && \
		rm -rf /build/ && \
		/sbin/ldconfig
#&& \
RUN             pip install --upgrade pip && \
		pip install future && \
		pip install scipy matplotlib numpy nose pyyaml emcee h5py && \
                pip install astropy healpy && \
		useradd -ms /bin/bash lss

WORKDIR /home/lss
RUN git clone https://github.com/hyperrealm/libconfig.git && \
    wget http://www.fftw.org/fftw-3.3.7.tar.gz && \
    wget https://downloads.sourceforge.net/project/healpix/Healpix_3.31/Healpix_3.31_2016Aug26.tar.gz && \
    git clone https://github.com/Libsharp/libsharp.git
RUN chown -R lss *
USER lss
COPY install-libs.sh .
RUN bash /home/lss/install-libs.sh
