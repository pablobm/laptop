#!/usr/bin/env sh

APPIMAGES_DIR="$HOME_BIN/appimages"
mkdir -p "$APPIMAGES_DIR"

if [ "$WHOAMI" = "root" ]; then
	echo 'FATAL: Do not run this script as root or with sudo.'
	exit 1
fi

if ! command -v sudo >/dev/null; then
	echo 'FATAL: Please install sudo before running this script.'
	exit 1
fi

if ! sudo -v 2>/dev/null; then
	echo 'FATAL: Please enable the current user to use sudo.'
	echo "TIP: Try with \`usermod -a -G sudo $(whoami)\` as root. Then you'll have to log out and back in or somethink like that..."
	exit 1
fi

