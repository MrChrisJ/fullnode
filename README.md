# Fullnode
Setting up a Bitcoin Fullnode on a Raspberry Pi 2

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/mrchrisj/fullnode?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This is the getting started guide for the Raspberry Pi Bitcoin Fullnodes sold on the ProTip crowd fund: [Not (Just) Made In China](https://www.startjoin.com/ProTip).

![Bitcoin Fullnode](https://github.com/MrChrisJ/fullnode/blob/master/Device_001.png)  
*Bitcoin/Pi Artwork by* [*Phneep*](Phneep.com)

# [Setup Guides](https://github.com/MrChrisJ/fullnode/tree/master/Setup_Guides#setup-guides)

1. [Setup Bitcoin Core 0.12 using latest version of Raspbian Jessie OSX](https://github.com/MrChrisJ/fullnode/blob/master/Setup_Guides/Setup_Jessie_Bitcoin_Core_0.12_OSX.md)
2. [Setup Bitcoin Core 0.12 using Jessie Lite for a Headless Fullnode](https://github.com/MrChrisJ/fullnode/blob/master/Setup_Guides/Setup_Jessie_Bitcoin_Core_0.12_OSX.md)
3. [Strip down Jessie](https://github.com/MrChrisJ/fullnode/blob/master/Setup_Guides/Strip_Down_Raspbian_Jessie.md) to make free space on your node
4. [Install Extras on your Fullnode](https://github.com/MrChrisJ/fullnode/blob/master/Setup_Guides/Setup_Jessie_Bitcoin_Extras.md) including IPFS and Iceweasel Browser
5. [Setup Bitcoin Configuration](https://github.com/MrChrisJ/fullnode/blob/master/Setup_Guides/bitcoin.conf)

# Motivation
The goal of this project is to learn and layout a simple process for someone to be able to build a Bitcoin Fullnode using nothing but low cost, open source available tools.

The main focus will be on educating and inspiring a new generation of people to begin hosting bitcoin fullnodes to help decentralise the network and to encourage enthusiasts to become janitors of the blockchain.

# README.TXT
==========
Getting started with your fullnode once you have bought it or followed the steps above. 

1. Attach external USB Thumb drive enclosed to Raspberry Pi (must be done first)
2. Attach Ethernet Cable (not included) to your router
3. Plug in micro USB cable in to to any USB/Phone charger using cable provided
4. After a few minutes the device will begin syncing with the Bitcoin Blockchain
5. Go to your computer’s command line and type: 

```
ssh pi@fullnode.local
```

Username: pi  
Password: raspberry  

Bitcoin should start automatically in headless mode, to get started type:

```
bitcoin-cli getinfo
```

After a few moments Bitcoin should report errors but telling you that is Loading the Blockchain, Verifying Blocks etc. Please be patient, this can take some time but while you’re making a nice cup of tea you can feel good knowing you are supporting the Bitcoin network by distributing its database.

You can also plug the Pi in to most modern TVs using an HDMI lead. Plug in a keyboard and mouse and type:

```
startx
```

This will load up the desktop mode. To load up Bitcoin Graphical User Interface type open up Terminal from top menu bar and type:

```
bitcoin-cli stop
```

You will need to wait a minute or so for Bitcoin Server to stop. Then type:

```
bitcoin-qt
```

You may get an error if you did it too quickly, no problem, just press the Up Arrow on your keyboard, hit return to try again. 

You may spend a long time on the “Activating Best Chain” progress report, this is a known issue in bitcoin and will be fixed in version 0.12. Once it loads you will be in the GUI where you can go to the menu and click Help>Debug Window to get nice graphs on network usage.

It is not recommended that you use the Fullnode as a wallet. Though if you want to play around with the JSON RPC it’s fine to put small change on it just for experimentation.


A signed Certificate of Authenticity is in your Home folder. If you want one which identifies you personally these are available on request.

Have fun and remember there’s more to come beginning 6th January 2016. Thank you for supporting the cause. From everyone at ProTip and the Fullnode project we hope you have a wonderful holiday season.

For more info visit fullnode.protip.is

# Further Reading
This repo is a work in progress. For further information checkout the following sites:

[Developer Examples on Bitcoin.org](https://bitcoin.org/en/developer-examples#testnet)  
[Bitcoin.it Wiki](https://en.bitcoin.it/wiki/Running_Bitcoin)  
[API Call Lists as of v0.8.0](https://en.bitcoin.it/wiki/Original_Bitcoin_client/API_calls_list)
[API reference (JSON-RPC)](https://en.bitcoin.it/wiki/API_reference_(JSON-RPC))
