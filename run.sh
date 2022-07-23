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

LAPTOP_RUNNER=$(readlink -f "$0")
LAPTOP_DIR=$(dirname "$LAPTOP_RUNNER")
CONFIGS_DIR="$LAPTOP_DIR"/configs
REPOS_DIR="$LAPTOP_DIR"/repos
HOME_BIN="$HOME/bin"
APPIMAGES_DIR="$HOME_BIN/appimages"
WHOAMI="$(whoami)"

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

mkdir -p "$HOME_BIN"
mkdir -p "$APPIMAGES_DIR"

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
sudo apt install -y direnv

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

# Get your user up and running with Postgres
sudo -u postgres createuser --superuser "$WHOAMI"

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

link_repo "minpac" ".config/nvim/pack/minpac/opt/minpac"

link_config "dot.gitconfig" ".gitconfig"
link_config "dot.config/nvim" ".config/nvim"
link_config "dot.gemrc" ".gemrc"
link_config "Sublime Text 3" ".config/sublime-text-3"

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
