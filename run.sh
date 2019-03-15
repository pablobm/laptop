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

LAPTOP_RUNNER=$(readlink -f "$0")
LAPTOP_DIR=$(dirname "$LAPTOP_RUNNER")
CONFIGS_DIR="$LAPTOP_DIR"/configs
REPOS_DIR="$LAPTOP_DIR"/repos
HOME_BIN="$HOME/bin"
DOWNLOADS_DIR="$HOME/Downloads"
WHOAMI="$(whoami)"

if ! command -v sudo >/dev/null; then
	echo 'FATAL: Please install sudo before running this script.'
	exit 1
fi

if ! sudo -v 2>/dev/null; then
	echo 'FATAL: Please enable the current user to use sudo.'
	echo "TIP: Try with \`usermod -a -G sudo $(whoami)\` as root. Then you'll have to log out and back in or somethink like that..."
	exit 1
fi

mkdir -p "$HOME_BIN"

sudo apt update
sudo apt upgrade -y

sudo apt install -y git
sudo apt install -y gitg
sudo apt install -y tig
sudo apt install -y curl
sudo apt install -y pass
sudo apt install -y silversearcher-ag
sudo apt install -y shellcheck
sudo apt install -y zsh
sudo apt autoremove

# Used by GnuPG to display pictures linked to keys.
# Recommended but not required.
sudo apt install -y xloadimage

# Used to interact with keyservers.
# Required by apt-key and asdf.
sudo apt install -y dirmngr

# Required to compile Ruby
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev

# Stretch package for Neovim is old and incompatible with
# current minpac at the time of writing.
# Installing static binary instead
NEOVIM_BIN="$HOME_BIN/nvim"
if [ ! -f "$NEOVIM_BIN" ]; then
	cd "$DOWNLOADS_DIR" && curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage && chmod u+x nvim.appimage && mv ./nvim.appimage "$NEOVIM_BIN"
fi

link_config "dot.gitconfig" ".gitconfig"
link_config "dot.config/nvim" ".config/nvim"

# Dracula theme for Gnome Terminal
# Requires a pre-existing terminal profile called "pablobm"
"$REPOS_DIR/dracula-gnome-terminal/install.sh" -s Dracula -p pablobm --skip-dircolors

# Ensure latest stable release of asdf
link_repo "asdf" ".asdf"
cd "$HOME/.asdf" && git checkout "$(git describe --abbrev=0 --tags)" > /dev/null


# Zsh and friends
link_config "dot.zshrc" ".zshrc"
link_repo "oh-my-zsh" ".oh-my-zsh"
link_repo "zsh-syntax-highlighting" ".oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
if [ "$SHELL" != "/usr/bin/zsh" ]; then
  sudo chsh -s /usr/bin/zsh "$WHOAMI"
  zsh
fi
