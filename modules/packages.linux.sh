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

# As of Debian Stretch, pass is at version 1.6.*,
# which doesn't support extensions.
# Install something more up to date.
cd "$REPOS_DIR/password-store" && sudo make install
cd "$REPOS_DIR/pass-otp" && sudo make install

# Stretch package for Neovim is old and incompatible with
# current minpac at the time of writing.
# Installing static binary instead
NEOVIM_BIN="$HOME_BIN/nvim"
NEOVIM_APPIMAGE_PATH="$APPIMAGES_DIR/nvim.appimage"
if [ ! -f "$NEOVIM_BIN" ]; then
	curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output "$NEOVIM_APPIMAGE_PATH" && chmod u+x "$NEOVIM_APPIMAGE_PATH" && ln -s "$NEOVIM_APPIMAGE_PATH" "$NEOVIM_BIN"
fi

