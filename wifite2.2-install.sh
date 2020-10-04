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
sleep 2
echo "THANKS FOR USING MY SCRIPT,DONATE SOME BTC TO SUPPORT ME :D (BTC: 3CQFyuKYzsarYZcYxMfsJBmzNGcuRQURSu)"
echo "Installation and configuration completed!"

#THANKS FOR USING MY SCRIPT, 
#PLS STAR AND DONATE SOME BTC TO SUPPORT ME :D 
#BTC 3CQFyuKYzsarYZcYxMfsJBmzNGcuRQURSu

exit