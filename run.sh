#!/usr/bin/env sh

LAPTOP_RUNNER=$(readlink -f "$0")
LAPTOP_DIR=$(dirname "$LAPTOP_RUNNER")

if ! command -v sudo >/dev/null; then
  echo 'FATAL: Please install sudo before running this script.'
  exit 1
fi

if ! sudo -v 2>/dev/null; then
  echo 'FATAL: Please enable the current user to use sudo.'
  echo "TIP: Try with \`usermod -a -G sudo $(whoami)\` as root. Then you'll have to log out and back in or somethink like that..."
  exit 1
fi

sudo apt update
sudo apt upgrade -y

sudo apt install -y git
sudo apt install -y gitg
sudo apt install -y tig
sudo apt install -y curl
sudo apt install -y pass

# Used by GnuPG to display pictures linked to keys.
# Recommended but not required.
sudo apt install -y xloadimage

# Used to interact with keyservers.
# Required by apt-key and asdf.
sudo apt install -y dirmngr

GITCONFIG="$HOME/.gitconfig"
if [ -f "$GITCONFIG" ] || [ -L "$GITCONFIG" ]; then
  echo "FATAL: The file $GITCONFIG already exists. Stopping to avoid overwriting your settings."
  echo "TIP: \`rm '$GITCONFIG'\` if you are happy to replace it."
  exit 1
fi
ln -s "$LAPTOP_DIR/configs/dot.gitconfig" "$GITCONFIG"
