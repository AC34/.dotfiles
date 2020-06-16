#!/usr/bin/env bash

#dpkg(debian)
if [ "$(uname -a)" == *"Debian"* ]; then
	 echo "Installation for debian"
	 PACKAGES="php nodejs npm docker docker-compose"
   echo "intall dev packeages?[$PACKAGES]"
	 read -p "(y/n)" yn
	 if [[ $yn = [yY] ]]; then
	   sudo apt install -y $PACKAGES
	 fi
	 echo "installation done"
fi

#dpkg(ubuntu)

#rpm(fedora v>=32)
if [ -f "/etc/fedora-release" ]; then
	 echo "Installation for fedora"
	 PACKAGES="php nodejs npm docker docker-compose"
   echo "intall dev packeages?[$PACKAGES]"
	 read -p "(y/n)" yn
	 if [[ $yn = [yY] ]]; then
	   sudo dnf install -y $PACKAGES
	 fi
	 echo "installation done"
fi

#rpm(centos)
