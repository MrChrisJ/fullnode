#!/bin/sh

# Install updates
sudo apt-get update
sudo apt-get upgrade -y

# Install dependencies for Bitcoin Core (not the GUI)
sudo apt-get install build-essential autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libboost-test-dev libboost-thread-dev libtool libevent-dev -y

# Install dependencies for Bitcoin QT (GUI)
sudo apt-get install libqt4-dev qt4-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev -y

# Setup Swap file
sudo sed -i '16s/.*/CONF_SWAPSIZE=1024/g' /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon

mkdir ~/bin
cd ~/bin
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
tar -xzvf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix/
../dist/configure --enable-cxx
make -j4
sudo make install
cd ~/bin
git clone -b 0.12 https://github.com/bitcoin/bitcoin
cd bitcoin/
./autogen.sh
./configure CPPFLAGS="-I/usr/local/BerkeleyDB.4.8/include -O2" LDFLAGS="-L/usr/local/BerkeleyDB.4.8/lib" --enable-upnp-default --with-gui=qt4
make -j2
sudo make install
sudo rm -r -f /home/pi/bin
mkdir /home/pi/.bitcoin/

# Remove the swap file we made earlier
sudo chmod -x /etc/init.d/dphys-swapfile
sudo swapoff -a
sudo rm /var/swap