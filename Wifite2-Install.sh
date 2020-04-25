#!/bin/bash

apt-get update 
apt-get upgrade -y
apt install git -y 
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
