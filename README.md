# pablobm's laptop setup script

Currently only supports Debian Stretch.

## How to use

1. Clone submodules: `git submodule init && git submodule update`.
1. Create a new profile for Gnome Terminal named "pablobm". It will receive the
   Dracula color scheme. This is because the installer apparently can't apply
   these to the default profile, or create a new profile itself.
1. Run the installer: `sh ./run.sh`.

## TODO

* Try file a PR for https://github.com/dracula/gnome-terminal that creates a
  new profile instead of expecting an existing, named ones. These instructions
  might come handy:
  https://askubuntu.com/questions/270469/how-can-i-create-a-new-profile-for-gnome-terminal-via-command-line
