#!/usr/bin/env sh

link_item()
{
	SRC_PATH="$1"
	DST_PATH="$2"

	if [ -L "$DST_PATH" ] && [ "$(realpath "$DST_PATH")" = "$(realpath "$SRC_PATH")" ]; then
		echo "SKIP: $DST_PATH <- $SRC_PATH"
	elif [ -f "$DST_PATH" ] || [ -L "$DST_PATH" ]; then
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
		sh "$MODULE_PATH"
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

mkdir -p "$HOME_BIN"

load_platform_specific_module "before-packages"
load_platform_specific_module "packages"
load_platform_specific_module "after-packages"

link_config "dot.gitconfig" ".gitconfig"
link_config "dot.config/nvim" ".config/nvim"
link_config "dot.gemrc" ".gemrc"
link_config "Sublime Text 3" ".config/sublime-text-3"

link_repo "minpac" ".config/nvim/pack/minpac/opt/minpac"

# Ensure latest stable release of asdf
link_repo "asdf" ".asdf"
cd "$HOME/.asdf" && git checkout "$(git describe --abbrev=0 --tags)" > /dev/null

# Zsh and friends
link_config "dot.zshrc" ".zshrc"
link_repo "oh-my-zsh" ".oh-my-zsh"
link_repo "zsh-syntax-highlighting" ".oh-my-zsh/custom/plugins/zsh-syntax-highlighting"


if [ "$SHELL" != "/usr/bin/zsh" && -e "/usr/bin/zsh"]; then
  sudo chsh -s /usr/bin/zsh "$WHOAMI"
  zsh
fi
if [ "$SHELL" != "/bin/zsh" && -e "/bin/zsh"]; then
  sudo chsh -s /bin/zsh "$WHOAMI"
  zsh
fi
