#!/usr/bin/env sh

BASEDIR=$(dirname $0)

# TODO: some DRY needed for the package download script below

mkdir "$BASEDIR/pack/tpope/start"
git clone https://tpope.io/vim/sensible.git "$BASEDIR/pack/tpope/start/sensible"

mkdir "$BASEDIR/pack/themes/start"
git clone https://github.com/dracula/vim.git "$BASEDIR/pack/themes/start/dracula"
