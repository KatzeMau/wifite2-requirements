#!/bin/bash


#Currently broke shit, if you know how to fix make a pull request
#Colors
#cyan='\e[0;36m'
#lightcyan='\e[96m'
#green='\e[0;32m'
#lightgreen='\e[1;32m'
#white='\e[1;37m'
#red='\e[1;31m'
#yellow='\e[1;33m'
#blue='\e[1;34m'
#echo ""
#sleep 2

#CHECK ROOT !!!!
#Currently broke shit, if you know how to fix make a pull request

#[[ `id -u` -eq 0 ]] > /dev/null 2>&1 || { echo -e $red "type sudo su and run again, or put sudo at the beginning of the command."; echo ; exit 1; }
# check internet 
#function checkinternet {
#  ping -c 1 google.com > /dev/null
#  if [[ "$?" != 0 ]]
#  then
#    echo  "Checking Internet ...: Could Not Connect
#     This Program Needs an Active Internet"
#    echo "Exiting Now"
#    echo && sleep 2
#    kexit
#  else
#    echo "Checking the Internet conection: CONNECTED"
#  fi
#}
#checkinternet
#sleep 2

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
echo "THANKS FOR USING MY SCRIPT,DONATE SOME BTC TO SUPPORT ME :D (BTC 3CQFyuKYzsarYZcYxMfsJBmzNGcuRQURSu)"

#THANKS FOR USING MY SCRIPT, 
#PLS STAR AND DONATE SOME BTC TO SUPPORT ME :D 
#BTC 3CQFyuKYzsarYZcYxMfsJBmzNGcuRQURSu

exit