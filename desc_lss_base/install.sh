#!/bin/bash
source /home/lss/.bashrc
cd $HOME

mkdir src
cd src

git clone https://github.com/hyperrealm/libconfig.git
cd libconfig
autoreconf --install
autoconf
./configure --prefix=/home/lss/local
# we need -k, as docs fail, I don't care
make -k
make -k install
cd ..


wget http://www.fftw.org/fftw-3.3.7.tar.gz
tar zxvf fftw-3.3.7.tar.gz
cd fftw-3.3.7
./configure  --prefix=/home/lss/local --enable-mpi --disable-fortran --enable-openmp 
make
make install
## and now the single version
./configure  --prefix=/home/lss/local --enable-mpi --disable-fortran --enable-openmp --enable-single
make
make install
cd ..



wget https://downloads.sourceforge.net/project/healpix/Healpix_3.31/Healpix_3.31_2016Aug26.tar.gz
tar zxvf Healpix_3.31_2016Aug26.tar.gz
cd Healpix_3.31
./configure <<EOF
2
Y
gcc
-O2 -Wall
ar -rsv
Y
libcfitsio.a
/usr/lib/x86_64-linux-gnu/
/usr/include
N
N
0
EOF
make
cp include/* /home/lss/local/include
cp lib/* /home/lss/local/lib
cd ..

git clone https://github.com/Libsharp/libsharp.git
cd libsharp
autoconf
CC=mpicc ./configure --prefix=/home/lss/local --enable-mpi
make
cp auto/include/* /home/lss/local/include
cp auto/lib/* /home/lss/local/lib
cd ..



## now that libs are build we can throw them away
cd $HOME
rm -rf src

# build CoLoRe
git clone https://github.com/damonge/CoLoRe.git
cd CoLoRe
mv ../Makefile.CoLoRe .
mv ../runCoLoRe .
chmod +x runCoLoRe
make -f Makefile.CoLoRe
export LD_LIBRARY_PATH=/home/lss/local/lib >>$HOME/.bashrc

git clone https://github.com/slosar/fastcat.git
cd fastcat
python setup.py install --user
cd ..

git clone https://github.com/damonge/NaMaster.git

git clone https://github.com/LSSTDESC/sacc.git
cd sacc
python setup.py install --user
cd ..


