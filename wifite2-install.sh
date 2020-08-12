#!/bin/bash

apt-get update 
apt-get upgrade -y
apt install git -y 
apt-get install aircrack-ng -y
apt-get install libssl-dev -y
apt-get install ocl-icd-libopencl1 -y
apt-get install build-essential -y
apt-get install wireshark -y
apt install reaver -y
apt-get -y install build-essential libpcap-dev aircrack-ng pixiewps
apt-get -y install wireshark
apt-get -y install libssl-dev
cd 
git clone https://github.com/aanarchyy/bully
cd bully*/
cd src/
make
make install 
cd
wget http://download.aircrack-ng.org/aircrack-ng-1.2-beta1.tar.gz tar -zxvf aircrack-ng-1.2-beta1.tar.gz 
cd aircrack-ng-1.2-beta1 
make
make install
cd
git clone https://github.com/hashcat/hashcat
cd hashcat
git submodule update –init
git clone https://github.com/hashcat/hashcat-utils
cd hashcat-utils/src
make
cd
wget https://github.com/aanarchyy/bully/archive/master.zip && unzip master.zip
cd bully*/
cd src/
make
make install 
cd
dpkg --configure -a
git clone https://github.com/derv82/wifite2.git
cd wifite2
git pull
sudo python setup.py install
cd
git clone https://github.com/ZerBea/hcxdumptool
git clone https://github.com/ZerBea/hcxtools
apt install libssl-dev -y 
cd hcxdumptool 
git pull
make 
make install 
cd 
cd hcxtools 
git pull
apt install libz-dev -y 
apt install libcurl4-gnutls-dev -y 
make 
make install
cd
apt-get install bully -y
git clone https://github.com/JPaulMora/Pyrit
apt-get install python -y
sudo apt-get install python3-dev -y
sudo apt-get install python2-dev -y
cd Pyrit
git pull
apt-get install libpcap-dev -y
python setup.py clean 
python setup.py build 
python setup.py install
cd 
apt-get install wireshark -y
apt-get install wireless-tools -y
apt-get install macchanger -y


exit
