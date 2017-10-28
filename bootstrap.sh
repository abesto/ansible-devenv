#!/bin/bash
set -euo pipefail
set -x
email="$1"; shift

echo 'Initializing git submodules for third-party libraries'
git submodule init

echo 'Upgrading system packages, installing bootstrap packages...'
sudo pacman -Syu
sudo pacman -S ansible lastpass-cli openssh python3 keychain xorg-xvidtune

echo 'LastPass login...'
mkdir -p ~/.config ~/.local/share
# ENV var works around https://github.com/lastpass/lastpass-cli/issues/323
env LPASS_DISABLE_PINENTRY=1 lpass login "$email"

echo 'Ansible bootstrap.yml run...'
ansible-playbook bootstrap.yml -i inventory --ask-become-pass "$@"

echo 'Switch from https origin on this git repo to SSH'
git remote rm origin
git remote add origin git@github.com:abesto/ansible-devenv.git
git fetch
git branch -u origin/master

echo 'Bootstrap done!'
