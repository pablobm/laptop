#!/usr/bin/env sh

set -e

link_item()
{
	SRC_PATH="$1"
	DST_PATH="$2"

	if [ -L "$DST_PATH" ] && [ "$(realpath "$DST_PATH")" = "$(realpath "$SRC_PATH")" ]; then
		echo "SKIP: $DST_PATH -> $SRC_PATH"
	elif [ -e "$DST_PATH" ] || [ -L "$DST_PATH" ]; then
		while true; do
			read -rp "You already have a $DST_PATH. What should I do? (S)kip/(O)verwrite: " answer
			case $answer in
				[Oo] ) rm "$DST_PATH" && ln -s "$SRC_PATH" "$DST_PATH"; break;;
				[Ss] ) echo "SKIP: $DST_PATH <- $SRC_PATH"; break;;
				* ) echo "Please answer 's' for skip or 'o' for overwrite.";;
			esac
		done
	else
		mkdir -p "$(dirname "$DST_PATH")"
		ln -s "$SRC_PATH" "$DST_PATH"
	fi
}

link_config()
{
	SRC_RELPATH="$1"
	DST_RELPATH="$2"

	link_item "$CONFIGS_DIR/$SRC_RELPATH" "$HOME/$DST_RELPATH"
}

link_repo()
{
	SRC_RELPATH="$1"
	DST_RELPATH="$2"

	link_item "$REPOS_DIR/$SRC_RELPATH" "$HOME/$DST_RELPATH"
}

detect_os()
{
	if [ "$(uname -s)" = "Darwin" ]; then
		echo "macos"
	else
		echo "linux"
	fi
}

load_platform_specific_module()
{
	MODULE_NAME="$1"

	MODULE_PATH="$LAPTOP_DIR/modules/$MODULE_NAME.$CURRENT_OS.sh"
	if [ -f "$MODULE_PATH" ]; then
		# shellcheck source=/dev/null
		. "$MODULE_PATH"
	fi
}

CURRENT_OS="$(detect_os)"

if [ "$CURRENT_OS" = "macos" ]; then
	if [ -z "$(command -v realpath)" ]; then
    # shellcheck disable=2016
		echo 'FATAL: Please install realpath with `brew install coreutils` before running this script.'
		exit 1
	fi
fi

LAPTOP_RUNNER=$(realpath "$0")
LAPTOP_DIR=$(dirname "$LAPTOP_RUNNER")
CONFIGS_DIR="$LAPTOP_DIR"/configs
REPOS_DIR="$LAPTOP_DIR"/repos
HOME_BIN="$HOME/bin"
WHOAMI="$(whoami)"

cd $LAPTOP_DIR && git submodule update --init && cd -

mkdir -p "$HOME_BIN"

load_platform_specific_module "before-packages"
load_platform_specific_module "packages"
load_platform_specific_module "after-packages"

link_config "dot.gitconfig" ".gitconfig"
link_config "dot.config/nvim" ".config/nvim"
link_config "dot.config/jj" ".config/jj"
link_config "dot.config/fish" ".config/fish"
link_config "dot.config/mise" ".config/mise"
link_config "dot.gemrc" ".gemrc"
link_config "dot.ctags" ".ctags"
link_config "Sublime Text 3" ".config/sublime-text-3"

fish -c 'mise install'

export PASSWORD_STORE_EXTENSIONS_DIR="$HOME/.password-store/.extensions"
mkdir -p "$PASSWORD_STORE_EXTENSIONS_DIR"
link_item "$REPOS_DIR/pass-otp/otp.bash" "$PASSWORD_STORE_EXTENSIONS_DIR/otp.bash"

echo
echo "That should be all. You may need to restart your terminal app for all changes to take effect"
