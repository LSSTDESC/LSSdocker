#!/bin/bash
source /home/lss/.bashrc
cd $HOME

mkdir src
mv libconfig src
mv fftw-3.3.7.tar.gz src
mv Healpix_3.31_2016Aug26.tar.gz src
mv libsharp src
cd src

cd libconfig
autoreconf --install
autoconf
./configure --prefix=/home/lss/local
# we need -k, as docs fail, I don't care
make -k
make -k install
cd ..


tar zxvf fftw-3.3.7.tar.gz
cd fftw-3.3.7
export CFLAGS="-fPIC -Ofast"
export FFLAGS="-fPIC -Ofast"
./configure  --prefix=/home/lss/local --enable-mpi --disable-fortran --enable-openmp 
make
make install
## and now the single version
./configure  --prefix=/home/lss/local --enable-mpi --disable-fortran --enable-openmp --enable-single
make
make install
cd ..



tar zxvf Healpix_3.31_2016Aug26.tar.gz
cd Healpix_3.31
./configure <<EOF
2
Y
gcc
-O2 -Wall -fPIC
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

cd libsharp
autoconf
CC="mpicc -O3 -fPIC" ./configure --prefix=/home/lss/local --enable-mpi
make
cp auto/include/* /home/lss/local/include
cp auto/lib/* /home/lss/local/lib
cd ..

rm -rf /home/lss/src
