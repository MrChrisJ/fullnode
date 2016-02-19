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
sudo apt-get upgrade -y
```

The -y flag tells the OS to answer "yes" to any prompts warning you of extra disk space required, we use this for convenience but it is not essential.

#### Install the software

We need `git` to get started. Once we have that, we can clone the `fullnode` project and run the `install` script.

```
sudo apt-get install -y git
cd
git clone https://github.com/MrChrisJ/fullnode.git
~/fullnode/install
```

#### TODO migrate everything below to scripts (wip)

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

#### To install IPFS go to [https://ipfs.io/docs/install/](https://ipfs.io/docs/install/)
Download the Linux ARM version [https://gobuilder.me/get/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs_master_linux-arm.zip](https://gobuilder.me/get/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs_master_linux-arm.zip)

#### Then in terminal...

```
cd ipfs
```

```
sudo mv ipfs /usr/local/bin/ipfs
```

And that's all there is to it. You now have your Bitcoin #Fullnode. Enjoy your Freedom!
