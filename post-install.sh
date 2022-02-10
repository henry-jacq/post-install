#!/bin/bash

# Created on: 10/02/22
# Created by: Henry
# Description: Install packages at post installation stage

if [[ $UID != 0 ]]; then
    echo "[-] Please run as root"
    exit 1
fi

echo -e "\n==> Adding chaotic-aur to pacman config\n"
sleep 2

# Downloading gpg keys
echo -e "=> Receiving the key\n"
pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
echo -e "=> Signing the received keys\n"
pacman-key --lsign-key FBA220DFC880C036

# Install keyring and mirrorlist
echo -e "=> Downloading and installing chaotic-aur keyring and mirrorlist\n"
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm

# Add repository to pacman config
echo -e "=> Adding chaotic-aur repository in /etc/pacman.conf\n"
echo "[chaotic-aur]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

echo "[+] Finished.."
