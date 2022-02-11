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

current_script_path()
{
	if [ "$CURRENT_OS" = "macos" ]; then
		echo "$*"
	else
		readlink -f "$*"
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

LAPTOP_RUNNER=$(current_script_path "$0")
LAPTOP_DIR=$(dirname "$LAPTOP_RUNNER")
CONFIGS_DIR="$LAPTOP_DIR"/configs
REPOS_DIR="$LAPTOP_DIR"/repos
HOME_BIN="$HOME/bin"
WHOAMI="$(whoami)"

mkdir -p "$HOME_BIN"

load_platform_specific_module "before-packages"
load_platform_specific_module "packages"

echo "GOT THIS FAR"
exit 0

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
