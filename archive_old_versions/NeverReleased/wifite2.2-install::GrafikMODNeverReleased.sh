#!/bin/bash


# NEW CODE #
# to skip any questions from APT
export DEBIAN_FRONTEND=noninteractive

AUTO_SIGNUP=0

while getopts "a" opt; do
	case $opt in
	a)
	    AUTO_SIGNUP=1
	    ;;
	esac
done

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#int the script, like update and upgrade
apt-get update 
apt-get upgrade -y

#Added Hashcat For cracking 
apt install hashcat

#Install all things that can be installed by apt
apt install git -y 
apt-get install aircrack-ng -y
apt-get install libssl-dev -y
apt install libz-dev -y 
apt install libcurl4-gnutls-dev -y 
apt-get install ocl-icd-libopencl1 -y
apt-get install build-essential -y
apt install reaver -y
apt-get -y install libpcap-dev
apt-get -y install aircrack-ng
apt-get -y install pixiewps
apt-get -y install libssl-dev
apt-get install bully -y
apt-get install python -y
apt-get install python3-dev -y
apt-get install python2-dev -y

#random dpkg just because.... jeah just because :)
dpkg --configure -a

#Download all files from Github and other websites
cd 
git clone https://github.com/aanarchyy/bully
wget http://download.aircrack-ng.org/aircrack-ng-1.2-beta1.tar.gz tar -zxvf aircrack-ng-1.2-beta1.tar.gz 
wget https://github.com/aanarchyy/bully/archive/master.zip && unzip master.zip
git clone https://github.com/derv82/wifite2.git
git clone https://github.com/ZerBea/hcxdumptool
git clone https://github.com/ZerBea/hcxtools
git clone https://github.com/JPaulMora/Pyrit

#Install what we downloaded
cd
cd bully*/
cd src/
make
make install 
cd
cd aircrack-ng-1.2-beta1 
make
make install
cd
cd wifite2
git pull
sudo python setup.py install
cd
cd hcxdumptool 
git pull
make 
make install 
cd 
cd hcxtools 
git pull
make 
make install
cd
cd Pyrit
git pull
python setup.py clean 
python setup.py build 
python setup.py install

#Nice Hashcat things :)
cd
git clone https://github.com/hashcat/hashcat
cd hashcat
git submodule update –init
git clone https://github.com/hashcat/hashcat-utils
cd hashcat-utils/src
make
cd

#Last things because they need youre preference like yes or no 
apt-get install wireshark -y
apt-get install wireless-tools -y
apt-get install macchanger -y
apt-get install wireshark -y


clear
clean
sleep 2
echo "

88888888888 888                        888                                            .d888                                        d8b                               
    888     888                        888                                           d88P"                                         Y8P                               
    888     888                        888                                           888                                                                             
    888     88888b.   8888b.  88888b.  888  888      888  888  .d88b.  888  888      888888 .d88b.  888d888      888  888 .d8888b  888 88888b.   .d88b.              
    888     888 "88b     "88b 888 "88b 888 .88P      888  888 d88""88b 888  888      888   d88""88b 888P"        888  888 88K      888 888 "88b d88P"88b             
    888     888  888 .d888888 888  888 888888K       888  888 888  888 888  888      888   888  888 888          888  888 "Y8888b. 888 888  888 888  888             
    888     888  888 888  888 888  888 888 "88b      Y88b 888 Y88..88P Y88b 888      888   Y88..88P 888          Y88b 888      X88 888 888  888 Y88b 888             
    888     888  888 "Y888888 888  888 888  888       "Y88888  "Y88P"   "Y88888      888    "Y88P"  888           "Y88888  88888P' 888 888  888  "Y88888             
                                                          888                                                                                        888             
                                                     Y8b d88P                                                                                   Y8b d88P             
                                                      "Y88P"                                                                                     "Y88P"              
888       888 d8b  .d888 d8b 888             .d8888b.       8888888b.                            d8b                                                 888             
888   o   888 Y8P d88P"  Y8P 888            d88P  Y88b      888   Y88b                           Y8P                                                 888             
888  d8b  888     888        888                   888      888    888                                                                               888             
888 d888b 888 888 888888 888 888888 .d88b.       .d88P      888   d88P .d88b.   .d88888 888  888 888 888d888 .d88b.  88888b.d88b.   .d88b.  88888b.  888888 .d8888b  
888d88888b888 888 888    888 888   d8P  Y8b  .od888P"       8888888P" d8P  Y8b d88" 888 888  888 888 888P"  d8P  Y8b 888 "888 "88b d8P  Y8b 888 "88b 888    88K      
88888P Y88888 888 888    888 888   88888888 d88P"           888 T88b  88888888 888  888 888  888 888 888    88888888 888  888  888 88888888 888  888 888    "Y8888b. 
8888P   Y8888 888 888    888 Y88b. Y8b.     888"            888  T88b Y8b.     Y88b 888 Y88b 888 888 888    Y8b.     888  888  888 Y8b.     888  888 Y88b.       X88 
888P     Y888 888 888    888  "Y888 "Y8888  888888888       888   T88b "Y8888   "Y88888  "Y88888 888 888     "Y8888  888  888  888  "Y8888  888  888  "Y888  88888P " 
                                                                                    888                                                                              
                                                                                    888                                                                              
                                                                                    888                                                                         

sleep 1
echo "THANKS FOR USING MY SCRIPT,DONATE SOME BTC TO SUPPORT ME :D (BTC: 3CQFyuKYzsarYZcYxMfsJBmzNGcuRQURSu)"
echo "Installation and configuration completed!"

#THANKS FOR USING MY SCRIPT, 
#PLS STAR AND DONATE SOME BTC TO SUPPORT ME :D 
#BTC 3CQFyuKYzsarYZcYxMfsJBmzNGcuRQURSu

exit