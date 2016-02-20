# Installing the Bitcoin #Fullnode to turn it in to a Freedom Machine
#### This is mashup of two instructions:
[Raspnode](http://raspnode.com/diyBitcoin.html) & [Tutorials & Technicalities - Compile Bitcoin Core on Raspberry Pi](http://blog.pryds.eu/2014/06/compile-bitcoin-core-on-raspberry-pi.html)

#### You will need:
1. 8Gb Micro SD Card (preferably Class 10 or above with wear protection)
2. Download Raspian Wheezy https://www.raspberrypi.org/downloads/raspbian / or your favourite distro

#### Insert Micro SD Card & Open up Terminal/Putty on Windows

#### List disks
```
diskutil list
````

##### Be carefull to select the correct disk OR YOU COULD LOSE DATA! If your SD Card is /dev/disk2 for example then:
```
diskutil umountDisk /dev/disk2
```  
```
sudo dd if=2015-05-05-raspbian-wheezy.img of=/dev/disk2 bs=4096 conv=noerror,sync
```   

This will take some time.  
Next take the micro SD out of the adapter and over to the Raspberry Pi 2 and connect it up to monitor and screen  
On first boot it will load up the raspi-config console. If this is not your first time then load it using the commmand:
```
sudo raspi-config
```
Select:  
1. Expand File System - click OK
2. Enable SSH
3. Change hostname to eg "fullnode" (without quotes)  
4. Reboot either via the config 

If you want you can reboot manually like so:
```
sudo reboot
```
#### Installing Updates

```
sudo apt-get update
```  
```
sudo apt-get upgrade -y
```  
The -y flag tells the OS to answer "yes" to any prompts warning you of extra disk space required, we use this for convenience but it is not essential.  

#### Install the dependencies
```
sudo apt-get install build-essential autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libboost-test-dev libboost-thread-dev libtool -y
```

#### Dependencies for Graphical User Interface (GUI) QT Wallet
```
sudo apt-get install libqt4-dev qt4-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev -y
```

#### Create a folder where we will install the files
```
mkdir ~/bin
```  
```
cd ~/bin
```

#### Install the Berkeley DB 4.8
```
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
```  
```
tar -xzvf db-4.8.30.NC.tar.gz
```  
```
cd db-4.8.30.NC/build_unix/
```  

#### Configuring the system and installing Berkeley DB  
#### the -j4 flag installs using all four cores on the Raspberry Pi  
```
../dist/configure --enable-cxx
```  
```
make -j4
```  
```
sudo make install
```  

#### Installing Bitcoin 0.11.2
```
cd ~/bin
```   
```
git clone -b v0.11.2 https://github.com/bitcoin/bitcoin.git
```  
```
cd bitcoin/
```  
```
./autogen.sh
```  
```
./configure CPPFLAGS="-I/usr/local/BerkeleyDB.4.8/include -O2" LDFLAGS="-L/usr/local/BerkeleyDB.4.8/lib" --enable-upnp-default --with-gui
```

```
make -j2
``` 
```
sudo make install
```  

You can delete ~/bin folder after the compiling.  
Once Bitcoin is installed you will need to create a .bitcoin folder inside of your home directory. This is really only necessary if you want to use Bitcoin Command Line Interface or run it headlessly. If you do simply enter:  
```
mkdir /home/pi/.bitcoin/
```   
```
cd /home/pi/.bitcoin
```  
```
nano bitcoin.conf
```  
This will open a blank text editor. Enter the following text as a minimum:
```
listen=1
server=1
dbcache=50
daemon=1
testnet=0
rpcuser=rpcuser
rpcpassword=changme_and_make_me_secure
```
Press ```cntr+X``` followed by ```Y``` then ```Enter``` to save changes and return back to the command line.

```
sudo blkid
```  
Make a note of the UUID

```
sudo nano /etc/fstab
```  

Enter the following:  
```
UUID=8736-1215    /home/pi/.bitcoin    vfat uid=pi,gid=pi,umask=0022,sync,auto,nosuid,rw,nouser    0    0
```  
```
sudo reboot
```  

## Installing the other apps

```
sudo apt-get install iceweasel
```  
```
sudo apt-get install tor
```  
```
sudo apt-get install openvpn resolvconf
```  

#### To install IPFS go to [https://ipfs.io/docs/install/](https://ipfs.io/docs/install/)
Download the Linux ARM version [https://gobuilder.me/get/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs_master_linux-arm.zip](https://gobuilder.me/get/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs_master_linux-arm.zip)
#### Then in terminal...
```
cd ipfs
```  
```
sudo mv ipfs /usr/local/bin/ipfs
```

## And that's all there is to it. You now have your Bitcoin #Fullnode. Enjoy your Freedom!
