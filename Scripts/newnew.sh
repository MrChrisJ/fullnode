#!/bin/sh
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install build-essential autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libb$
sudo apt-get install libqt4-dev qt4-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev -y
sed '16d' /etc/dphys-swapfile
sed 's/16d/CONF_SWAPSIZE=1024/g' /etc/dphys-swapfile
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
sudo blkid
sudo mkfs.vfat /dev/sda1
sudo blkid
uuid = echo "What is your uuid number"
read uuid
sed 's/4d/UUID=$uuid /home/pi/.bitcoin   vfat uid=pi,gid=pi,umask=0022,sync,auto,nosuid,rw,nouser   0  0/g' /etc/fstab
sudo apt-get remove --purge minecraft-pi wolfram-engine scratch oracle-java8-jdk omxplayer penguinspuzzle greenfoot bluej claws-mail sonic-pi dillo netsurf-gtk -y
sudo apt-get update --fix-missing
sudo apt-get install iceweasel --no-install-recommends
sudo apt-get install tor -y
sudo apt-get install openvpn reolvconf -y
sudo apt-get install nodejs npm
wget https://nodejs.org/dist/v4.0.0/node-v4.0.0-linux-armv61.tar.gz
tar -xvf node-v4.0.0-linux-armv61.tar.gz
cd node-v4.0.0-linux-armv61
sudo cp -R * /usr/local/
sudo npm install npm@latest -g
wget https://gobuilder.me/get/github.com/ipfs/cmd/ipfs/ipfs_master_linux-arm.zip
cd ipfs
sudo mv ipfs /usr/local/bin/ipfs
cd ..
git clone https://github.com/ipfs/station.git
cd station
npm install
npm cache clean
npm start
cd ~
mkdir btchip
cd btchip
wget https://hardwarewallet.com/zip/add_btchip_driver.sh
sudo bash add_btchip_driver.sh
sudo udevadm control --reload-rules
git clone https://github.com/LedgerHQ/btchip-python.git
cd btchip-python
sudo python setup.py install
cd samples
python getFirmwareVersion.py
cd ../btchip
cd ../..
git clone https://github.com/LedgerHQ/btchip-c-api.git
cd btchip-c-api
mkdir bin
make
make -f Makefile.hidapi
cd bin
./btchip_getFirmwareVersion
cd ../..
cd ..
git clone https://github.com/LedgerHQ/btchip-js-api
cd ~
sudo apt-get --yes install python-pip python-slowaes python-socksipy
sudo apt-get --yes install pyqt4-dev-tools python-ecdsa python-zbar
sudo apt-get --yes install python-qt4
sudo pip install pyasn1 pyasn1-modules pbkdf2 tlslite qrcode
git clone https://github.com/spesmilo/electrum.git
cd electrum
pyrcc4 icons.qrc -o gui/qt/icons_rc.py
python mki18n.py
python setup.py sdist --format=zip,gztar
                                                                      