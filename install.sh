#!/bin/bash

# https://git-scm.com/book/en/v2/Git-Tools-Submodules
git clone --recurse-submodules https://github.com/dru26/dotfiles.git


sudo_msg="sudo password: "

# update the system
sudo -p $sudo_msg pacman -Syu

# install aura
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg
sudo -p $sudo_msg pacman -U <the-package-file-that-makepkg-produces>

# read the toml file
sudo -p $sudo_msg aura -Syu