#!/bin/bash
source /home/lss/.bashrc
cd $HOME

# build CoLoRe
git clone https://github.com/damonge/CoLoRe.git
cd CoLoRe
mv ../Makefile.CoLoRe .
mv ../runCoLoRe .
chmod +x runCoLoRe
make -f Makefile.CoLoRe
export LD_LIBRARY_PATH=/home/lss/local/lib >>$HOME/.bashrc

cd $HOME
git clone https://github.com/slosar/fastcat.git
cd fastcat
python setup.py install --user
cd ..

cd $HOME
git clone https://github.com/damonge/NaMaster.git
cd NaMaster
CC=mpicc CFLAGS="-O3 -I/home/lss/local/include -L/home/lss/local/lib" ./configure  --prefix=/home/lss/local
make
make install
CC=mpicc CFLAGS="-I/home/lss/local/include -L/home/lss/local/lib" python setup.py install --user


cd $HOME
git clone https://github.com/LSSTDESC/sacc.git
cd sacc
python setup.py install --user
cd ..

echo "export PATH=/home/lss/local/bin:\$PATH" >> /home/lss/.bashrc
echo "export LD_LIBRARY_PATH=/home/lss/local/lib:\$LD_LIBRARY_PATH" >> /home/lss/.bashrc
