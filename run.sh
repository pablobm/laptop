#!/usr/bin/env sh

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

sudo apt install -y git
