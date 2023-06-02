#!/usr/bin/env sh

# Get your user up and running with Postgres
sudo -u postgres createuser --superuser "$WHOAMI"

# Dracula theme for Gnome Terminal
# Requires a pre-existing terminal profile called "pablobm"
"$REPOS_DIR/dracula-gnome-terminal/install.sh" -s Dracula -p pablobm --skip-dircolors

