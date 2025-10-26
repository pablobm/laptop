# pablobm's laptop setup script

Tested with Debian 13 (Trixie) and macOS (can't remember what version last).

## How to use

1. Make `sudo` work with your user. On Debian I can run this command and reboot:
```
$ su - -c 'usermod --append --groups sudo pablobm'
```
1. Install Git.
1. Clone this repo in an appropriate location.
1. Run the installer: `sh ./run.sh`.

## TODO

* Try file a PR for https://github.com/dracula/gnome-terminal that creates a
  new profile instead of expecting an existing, named ones. These instructions
  might come handy:
  https://askubuntu.com/questions/270469/how-can-i-create-a-new-profile-for-gnome-terminal-via-command-line
