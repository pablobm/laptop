#!/usr/bin/env sh

sudo apt update
sudo apt upgrade -y

sudo apt install -y git
sudo apt install -y gitg
sudo apt install -y tig
sudo apt install -y curl
sudo apt install -y silversearcher-ag
sudo apt install -y shellcheck
sudo apt install -y zsh
sudo apt install -y g++
sudo apt install -y automake
sudo apt install -y autoconf
sudo apt install -y postgresql
sudo apt install -y postgresql-server-dev-all

# Used by GnuPG to display pictures linked to keys.
# Recommended but not required.
sudo apt install -y xloadimage

# Used to interact with keyservers.
# Required by apt-key and asdf.
sudo apt install -y dirmngr

# Required to compile Ruby
sudo apt install -y libssl-dev libreadline-dev zlib1g-dev

# Required for pass-otp
sudo apt install -y oathtool wl-clipboard tree

sudo apt autoremove
