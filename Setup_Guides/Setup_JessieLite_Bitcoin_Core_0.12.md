# Installing a Headless Bitcoin #Fullnode on Raspberry Pi 2 Model B
#### This is mashup of two instructions:
[Raspnode](http://raspnode.com/diyBitcoin.html) & [Tutorials & Technicalities - Compile Bitcoin Core on Raspberry Pi](http://blog.pryds.eu/2014/06/compile-bitcoin-core-on-raspberry-pi.html)

These instructions are for developers or those who just want to create a fast, lightweight Fullnode. This will not give a Desktop Graphical User Interface, just a command line only interface.

#### You will need:
1. 4Gb Micro SD card (preferably Class 10 or above with wear protection)
2. Download Raspian Jessie https://www.raspberrypi.org/downloads/raspbian / or your favourite distro

#### Installing Raspbian Jessie Lite (OSX Only)
You may need a micro SD Card Adapter as many computers come with traditional SD Memory Card Slots. Insert the card & open up Terminal, do this by going to Spotlight and begin typing "Terminal".

#### List disks
List all the dists on your computer with this command:  
```
diskutil list
```  
This should give you a list of disks. The SD Card you inserted is likely to be the last one on the list.  

If your SD Card is /dev/disk3 for example then type:
```
diskutil umountDisk /dev/disk3
```  
**Be very carefull with the next step.** What we are about to do can destroy data, it is recommended you detach any hard drives or memory cards that you don't need so that it is impossible to overwrite them. 
```
sudo dd if=2015-11-21-raspbian-jessie-lite.img of=/dev/disk3 bs=4096 conv=noerror,sync
```   
This will copy the img file to the SD Card. This usually only take a few mins with Jessie Lite as it is a lightweight operating system.   

#### Starting Up Raspbian Jessie Lite on the Pi
Take the micro SD out of its adapter and your computer and put it in to the Raspberry Pi 2 and connect it up to monitor and screen  
On first boot it will load up the raspi-config console. If this is not your first time then load it using the commmand:
```
sudo raspi-config
```
Select:  
1. Expand File System - click OK  
2. Enable SSH  
3. Change hostname to eg "fullnode" (without quotes)   
4. Click Finish by using Tab Key and Reboot  

#### Installing Updates
Make sure the install is up to date like so:   
```
sudo apt-get update
```  
```
sudo apt-get upgrade -y
```  
*The -y flag tells the OS to answer "yes" to any prompts warning you of extra disk space required, we use this for convenience but it is not essential.*  

#### Install the Dependencies for Bitcoin
```
sudo apt-get install build-essential autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libboost-test-dev libboost-thread-dev libtool libevent-dev git -y
```

#### Increase Swap File
To make sure you don't run out of memory increase Swap file size, you can return this back to default after install.  
```
sudo nano /etc/dphys-swapfile
```  
Change the default size to:  
```
CONF_SWAPSIZE=1024
```  
To exit ```cntr+X``` then ```Y```  
```
sudo dphys-swapfile setup
```    
```
sudo dphys-swapfile swapon
```  

#### Create a folder where we will install the files
```
mkdir ~/bin
```  
```
cd ~/bin
```

#### Installing Bitcoin 0.12    
```
git clone -b 0.12 https://github.com/bitcoin/bitcoin
```  
```
cd bitcoin/
```  
```
./autogen.sh
```  
```
./configure --enable-upnp-default --disable-wallet
```  
```
make
``` 
```
sudo make install
```  

You can delete ~/bin folder after the compiling.  
Once Bitcoin is installed you will need to create a .bitcoin folder inside of your home directory. This is really on necessary if you want to use Bitcoin Command Line Interface or run it headlessly. If you do simply enter:

#### Return Swap File Back to Default
Remember earlier we increased the swap file size. Some people choose to disable Swapfile altogether by setting ```CONF_SWAPSIZE=0``` however we are going to do it slightly differently see [Issue 20](https://github.com/MrChrisJ/fullnode/issues/20).  

```
sudo chmod -x /etc/init.d/dphys-swapfile
sudo swapoff -a
sudo rm /var/swap
```

Note to re-enable just reverse the process:  
```
sudo chmod +x /etc/init.d/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
```  

#### Create Bitcoin Data Folder
By default on Linux the data folder is in ~/.bitcoin. You bitcoin.conf file must be in this location for bitcoind to run.
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
#### Starting Bitcoind
To start Bitcoind simply run the following command:  
```
bitcoind -daemon
```
#### And that's all there is to it. Youe your Bitcoin #Fullnode is up and running  
It will take a long while to sync the blockchain from scratch but you can either copy it from another computer if you have another node running.
