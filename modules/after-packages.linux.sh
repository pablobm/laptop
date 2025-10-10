#!/usr/bin/env sh

TERMINAL_DCONF_DIR=/org/gnome/terminal/legacy/profiles:

# TODO: don't create the profile if it exists already
# Create a profile 'Default'
# Taken from https://github.com/dracula/gnome-terminal/blob/ccc75a2d7fd915e80d95059a80899249e7161e06/src/profiles.sh#L14
profile_id="$(uuidgen)"
dconf write "$TERMINAL_DCONF_DIR/default" "'$profile_id'"
dconf write "$TERMINAL_DCONF_DIR/list" "['$profile_id']"
profile_dir="$TERMINAL_DCONF_DIR/:$profile_id"
dconf write "$profile_dir/visible-name" "'Default'"
dconf write "$profile_dir/use-custom-command" "true"
dconf write "$profile_dir/custom-command" "'/usr/bin/fish'"
dconf write "$profile_dir/font" "'FantasqueSansM Nerd Font Mono 12'"

# Dracula theme for Gnome Terminal
"$REPOS_DIR/dracula-gnome-terminal/install.sh" --scheme Dracula --profile Default --skip-dircolors

# Set Caps Lock to behave as Ctrl
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:ctrl_modifier']"
