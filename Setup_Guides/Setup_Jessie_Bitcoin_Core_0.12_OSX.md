# Installing the Bitcoin #Fullnode to turn it in to a Freedom Machine
#### This is mashup of two instructions:
[Raspnode](http://raspnode.com/diyBitcoin.html) & [Tutorials & Technicalities - Compile Bitcoin Core on Raspberry Pi](http://blog.pryds.eu/2014/06/compile-bitcoin-core-on-raspberry-pi.html) and forms part of the [Bitcoin Fullnode Project](https://github.com/MrChrisJ/fullnode).  

#### You will need:
1. 8Gb Micro SD Card (preferably Class 10 or above with wear protection)
2. Download Raspian Jessie https://www.raspberrypi.org/downloads/raspbian / or your favourite distro

The new version of Raspbian Jessie is out: 2016-02-09-raspbian-jessie.img, at the time of writing includes bundled software which takes up extra room on the disk. To remove these packages see instructions on Strip Down Raspian.  

#### Step 1 - Installing Raspbian on to Micro SD
See [Instalation Instructions](https://www.raspberrypi.org/documentation/installation/installing-images/README.md) on the Raspberry Pi website that includes all operating systems.  

##### These instructions are for Mac OSX

Insert Micro SD Card & Open up Terminal  

List disks:  
```
diskutil list
````

##### Be carefull to select the correct disk OR YOU COULD LOSE DATA! If your SD Card is /dev/disk2 for example then:
```
diskutil umountDisk /dev/disk2
```  
```
sudo dd if=2016-02-09-raspbian-jessie.img of=/dev/disk2 bs=4096 conv=noerror,sync
```   

This will take some time.  

#### Turning on the Pi
Take the micro SD out of the adapter and over to the Raspberry Pi 2 and connect it up to monitor and screen.  
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
sudo apt-get install build-essential autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libboost-test-dev libboost-thread-dev libtool libevent-dev -y
```

#### Dependencies for Graphical User Interface (GUI) QT Wallet
```
sudo apt-get install libqt4-dev qt4-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev -y
```
#### Increase Swap File size for instalation
Make sure you have at least 2Gb free on the card before starting and increase your swap file like so:
```
sudo nano /etc/dphys-swapfile
```  
Then enter  
```
CONF_SWAPSIZE=1024
```  
Then hit control+X and click Y to save and Enter. Then type the command:  
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
*Note the -j4 flag installs using all four cores on the Raspberry Pi*  
```
../dist/configure --enable-cxx
```  
```
make -j4
```  
```
sudo make install
```  

#### Installing Bitcoin 0.12
```
cd ~/bin
```   
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
./configure CPPFLAGS="-I/usr/local/BerkeleyDB.4.8/include -O2" LDFLAGS="-L/usr/local/BerkeleyDB.4.8/lib" --enable-upnp-default --with-gui=qt4
```  

In this next step we are going to build the executable files using the [Make tool](https://en.wikipedia.org/wiki/Make_(software)). The ```-j2``` flag tells the computer to use two of the CPU cores. You might find that you get errors, if you do simply drop the flag and use ```make``` on its own instead.
```
make -j2
```  
```
sudo make install
```
Usually the errors will not be apparent until this last step. In addition to the ```-j2``` flag you may also be getting errors if: 

1. The memory card does not have enough space
2. You did not set the swap file size high enough
3. You did not install all of the dependencies near the start of the tutorial

You can delete ~/bin folder after the compiling to save space with:
```
sudo rm -r -f /home/pi/bin
```  
The ```-r``` means recursive (deletes all subfolders) and the ```-f``` means Force delete without prompting.  

#### Setting up Bitcoin Data Folder
Once Bitcoin is installed you will need to create a .bitcoin folder inside of your home directory. This is really only necessary if you want to use Bitcoin Command Line Interface (CLI) and run it headlessly. If you do you need to make sure you have enough space. At the time of writing the Bitcoin Blockchain is around 66Gb which means realistically you will need MicroSD or an external Drive that is at least 128Gb.

```
mkdir /home/pi/.bitcoin/
```   
If you have an internal MicroSD drive large enough for the whole blockchain you can skip to the section on creating the bitcoin.conf file. Assuming you will be using external media then do the following:  

Display information about block devices attached to the Raspberry Pi...
```
sudo blkid
```  
Make a note of the drive name eg ```/dev/sda1```. Then format the drive you wish to use *if* this hasn't been done already. FAT32 is recommended for compatibility with other devices. Skip this step if the device was formatted on your computer. 
```
sudo mkfs.vfat /dev/sda1
```  
Then do the blkid command again:  
```
sudo blkid
```  
Make a note of the new UUID number eg. 8736-1215
```
sudo nano /etc/fstab
```  
Enter the following:  
```
UUID=8736-1215    /home/pi/.bitcoin    vfat uid=pi,gid=pi,umask=0022,sync,auto,nosuid,rw,nouser    0    0
```  
Replacing the "8736-1215" with whatever your drive actually is. Then reboot and the external drive will automatically mount to /home/pi/.bitcoin.
```
sudo reboot
```  

Next let's go in to our Bitcoin data directory:  
```
cd /home/pi/.bitcoin
```  
Using nano text editor we will create the Bitcoin Configuration file bitcoin.conf
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

#### Starting Bitcoind
To start Bitcoin Daemon type:  
```
bitcoind -daemon
```  
To check the status run this command:  
```
bitcoin-cli getinfo
```  
While Bitcoin is starting up you will get an error like this one:  
```
error code: -28
error message:
Verifying blocks...
```  
This is normal, be patient and use the up arrow on the keyboard to toggle through the previous used commands. Keep re-entering ```bitcoin-cli getinfo`` and eventually you will see something like this:  
```
{
  "version": 120000,
  "protocolversion": 70012,
  "walletversion": 60000,
  "balance": 0.00000000,
  "blocks": 96,
  "timeoffset": 0,
  "connections": 4,
  "proxy": "",
  "difficulty": 1,
  "testnet": false,
  "keypoololdest": 1455980870,
  "keypoolsize": 101,
  "paytxfee": 0.00000000,
  "relayfee": 0.00001000,
  "errors": ""
}
```
**Congratulations you are now running Bitcoin Core 0.12!**

#### Running Bitcoin QT in Desktop Mode
To get Bitcoin QT running you will first need to make sure that Bitcoin Daemon has been stopped using this command:  
```
bitcoin-cli stop
```  
You will need to load up the Desktop on the Pi with the following command which can only be done if it is attached to a monitor and keyboard directly, this won't work using SSH.  
```
startx
```  
After the desktop has loaded open up a terminal window from the menu bar (it's the little black box icon) and type:  
```
bitcoin-qt
```  
You will now see the Graphical User Interface load up. Remember you cannot run both Bitcoind and Bitcoin QT at the same time. 

#### And that's all there is to it. You now have your Bitcoin #Fullnode. Enjoy your Freedom!
