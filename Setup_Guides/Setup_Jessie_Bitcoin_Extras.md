# Installing Extras on the New Fullnode OS

#### Installing Iceweasel Browser on Raspbian Jessie
Iceweasel is the Firefox Browser for the Arm processor. To install it on the latest version of Jessie 2016-02-09 you will need to add extra flags like so: 
```
sudo apt-get update --fix-missing
```  
```
sudo apt-get install iceweasel --no-install-recommends
```  

#### Installing Tor and VPN Services
Note that you will need to purchase a VPN to secure all your traffic in addition to Bitcoin. We recommend [Mullvad](https://mullvad.net). For the Iceweasel Browser you can install [Zenmate VPN](https://zenmate.com/free-vpn/).  
Install Tor (note this is not the browser, just the service that runs in the background)
```
sudo apt-get install tor -y
```  
```
sudo apt-get install openvpn resolvconf -y
```  
#### Installing NodeJs on the Pi
Got this from here: [the Wia Blog](http://blog.wia.io/installing-node-js-v4-0-0-on-a-raspberry-pi/) 

#### Downloading NodeJS v4.0.0
If you are running Raspbian Wheezy install NodeJS and NPM like so:
```
sudo apt-get install nodejs npm
```  
To install v4 of NodeJS on the Pi use these instructions or alternatively checkout this neat app [https://github.com/tj/n](https://github.com/tj/n).
```
wget https://nodejs.org/dist/v4.0.0/node-v4.0.0-linux-armv7l.tar.gz
```  
```
tar -xvf node-v4.0.0-linux-armv7l.tar.gz
```  

```
cd node-v4.0.0-linux-armv7l
```  
Copy to /usr/local
```
sudo cp -R * /usr/local/
```

#### Installing NPM
```
sudo npm install npm@latest -g
```  
#### IPFS - InterPlanetary File System
IPFS is a distributed file system for the web, it is an emerging technology still in its early stages of development, please have fun and test it, [report any issues](https://github.com/ipfs/ipfs/issues) to the open source dev team.  

1. To install IPFS go to [https://ipfs.io/docs/install/](https://ipfs.io/docs/install/)
2. Download the Linux ARM version [https://gobuilder.me/get/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs_master_linux-arm.zip](https://gobuilder.me/get/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs_master_linux-arm.zip)
3. Then to complete open a terminal window and type...
```
cd ipfs
```  
```
sudo mv ipfs /usr/local/bin/ipfs
```

#### Installing IPFS Station
This is a GUI for IPFS if you are unsure of command line. At the time of writing this software is still a big buggy on the Raspberry Pi. Please report any issues or success stories to help other members of the community.  
```
cd ..
```
```
git clone https://github.com/ipfs/station.git
```
```
npm cache clean
```  

