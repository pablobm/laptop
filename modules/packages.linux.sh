#!/usr/bin/env sh

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
  git \
  gitg \
  tig \
  curl \
  silversearcher-ag \
  shellcheck \
  g++ \
  make \
  automake \
  autoconf \
  universal-ctags \
  direnv \
  libffi-dev \
  libyaml-dev \
  pass \
  pass-otp \
  uuid-runtime # For the installer for the Dracula theme on gnome-terminal

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

PATH_TO_KEYRING_FOR_FISH="/etc/apt/trusted.gpg.d/shells_fish_release_4.gpg"
BASE_URL_FOR_FISH="http://download.opensuse.org/repositories/shells:/fish:/release:/4/Debian_12/"
PATH_TO_SOURCES_LIST_FOR_FISH="/etc/apt/sources.list.d/shells:fish:release:4.list"
curl -fsSL "$BASE_URL_FOR_FISH/Release.key" | gpg --dearmor | sudo tee "$PATH_TO_KEYRING_FOR_FISH" > /dev/null
echo "deb $BASE_URL_FOR_FISH /" | sudo tee "$PATH_TO_SOURCES_LIST_FOR_FISH"

PATH_TO_KEYRING_FOR_MISE=/etc/apt/keyrings/mise-archive-keyring.gpg
BASE_URL_FOR_MISE=https://mise.jdx.dev
PATH_TO_SOURCES_LIST_FOR_MISE=/etc/apt/sources.list.d/mise.list
curl -fsSL "$BASE_URL_FOR_MISE/gpg-key.pub" | gpg --dearmor | sudo tee "$PATH_TO_KEYRING_FOR_MISE" 1> /dev/null
echo "deb [signed-by=$PATH_TO_KEYRING_FOR_MISE arch=amd64] $BASE_URL_FOR_MISE/deb stable main" | sudo tee "$PATH_TO_SOURCES_LIST_FOR_MISE"

sudo apt update
sudo apt install -y fish
sudo apt install -y mise

sudo apt autoremove

# Debian's Neovim package is behind latest, more than I'd prefer.
# Installing static binary instead
NEOVIM_BIN="$HOME_BIN/nvim"
NEOVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage"
NEOVIM_FILE_NAME=$(basename "$NEOVIM_DOWNLOAD_URL")
NEOVIM_APPIMAGE_PATH="$APPIMAGES_DIR/$NEOVIM_FILE_NAME"
if [ ! -f "$NEOVIM_BIN" ]; then
	curl -L "$NEOVIM_DOWNLOAD_URL" --location --output "$NEOVIM_APPIMAGE_PATH" && chmod u+x "$NEOVIM_APPIMAGE_PATH" && ln -s "$NEOVIM_APPIMAGE_PATH" "$NEOVIM_BIN"
fi

# Install Nerd Font with extra glyphs (https://www.nerdfonts.com)
FONT_ZIP_NAME=FantasqueSansMono.zip
FONTS_DIR="$HOME/.local/share/fonts/"
curl --location --output "/tmp/$FONT_ZIP_NAME" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/$FONT_ZIP_NAME"
unzip "/tmp/$FONT_ZIP_NAME" -d "$FONTS_DIR"
