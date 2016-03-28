#### Strip Down Raspbian 
Raspbian Jessie comes with a lot of bundled software which you may not need. Here are some instructions you can use to save space on your #Fullnode.  

These following steps are optional, just delete what you don't want. Thanks to Glenn Geenen's Blog Post: [Strip down Raspbian](http://glenngeenen.be/strip-down-raspbian/) for some of the commands used here.

```
sudo apt-get remove minecraft-pi -y
```  
```
sudo apt-get remove --purge wolfram-engine scratch -y
```  
```
sudo apt-get remove --purge oracle-java8-jdk -y
```  
```
sudo apt-get remove --purge omxplayer penguinspuzzle -y
```  
```
sudo apt-get remove --purge greenfoot bluej -y
```  
```
sudo apt-get remove --purge claws-mail -y
```  
```
sudo apt-get remove --purge sonic-pi -y
```  
Remove Libre Office
```
sudo apt-get remove --purge libreoffice*
```  
At the end of any of these steps you can run:  
```
sudo apt-get clean
sudo apt-get autoremove -y
```  

This should leave you with about 4Gb of free space.

