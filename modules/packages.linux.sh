#!/usr/bin/env sh

sudo apt update
sudo apt upgrade -y


# Read from the new repos
sudo apt update

sudo apt install -y git
sudo apt install -y gitg
sudo apt install -y tig
sudo apt install -y curl
sudo apt install -y silversearcher-ag
sudo apt install -y shellcheck
sudo apt install -y g++
sudo apt install -y automake
sudo apt install -y autoconf
sudo apt install -y ctags
sudo apt install -y direnv
sudo apt install -y wget

# Used by GnuPG to display pictures linked to keys.
# Recommended but not required.
sudo apt install -y xloadimage

# Used to interact with keyservers.
# Required by apt-key.
sudo apt install -y dirmngr

# Required to compile Ruby
sudo apt install -y libssl-dev libreadline-dev zlib1g-dev

# Required for pass-otp
sudo apt install -y oathtool wl-clipboard tree


#
# Packages from alternative repos
#

sudo install -dm 755 /etc/apt/keyrings

PATH_TO_KEYRING_FOR_MISE=/etc/apt/keyrings/mise-archive-keyring.gpg
BASE_URL_FOR_MISE=https://mise.jdx.dev
PATH_TO_SOURCES_LIST_FOR_MISE=/etc/apt/sources.list.d/mise.list
wget -qO - "$BASE_URL_FOR_MISE/gpg-key.pub" | gpg --dearmor | sudo tee "$PATH_TO_KEYRING_FOR_MISE" 1> /dev/null
echo "deb [signed-by=$PATH_TO_KEYRING_FOR_MISE arch=amd64] $BASE_URL_FOR_MISE/deb stable main" | sudo tee "$PATH_TO_SOURCES_LIST_FOR_MISE"
sudo apt install -y mise

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
NEOVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage"
NEOVIM_FILE_NAME=$(basename "$NEOVIM_DOWNLOAD_URL")
NEOVIM_APPIMAGE_PATH="$APPIMAGES_DIR/$NEOVIM_FILE_NAME"
if [ ! -f "$NEOVIM_BIN" ]; then
	curl -L "$NEOVIM_DOWNLOAD_URL" --location --output "$NEOVIM_APPIMAGE_PATH" && chmod u+x "$NEOVIM_APPIMAGE_PATH" && ln -s "$NEOVIM_APPIMAGE_PATH" "$NEOVIM_BIN"
fi

