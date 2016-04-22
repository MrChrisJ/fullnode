

Using info found in https://github.com/bitseed-org/bitcoin-box/blob/master/tools/torsetup.sh it is possible to configure your fullnode to also run over TOR

First install TOR
```
sudo apt-get install tor
```

Then use the following commands to add the bitcoin hidden service to TOR
```
sudo echo "HiddenServiceDir /var/lib/tor/bitcoin-service/" >> /etc/tor/torrc
sudo echo "HiddenServicePort 8333 127.0.0.1:8333" >> /etc/tor/torrc
```

Then reload the TOR service
```
sudo service tor reload
```

Then determine your onion address
```
sudo cat /var/lib/tor/bitcoin-service/hostname
```

Then modify your bitcoin.conf file with the following additional lines

```
onion=127.0.0.1:9050
listen=1
bind=127.0.0.1:8333
externalip=(your onion address) 
#these are other Tor nodes that will help your node find peers
seednode=nkf5e6b7pl4jfd4a.onion
seednode=xqzfakpeuvrobvpj.onion
seednode=tsyvzsqwa2kkf6b2.onion
#these lines help limit potential DOS attacks over Tor
banscore=10000
bantime=11

#if you would like your node to only connect over tor use
onlynet=tor
```
