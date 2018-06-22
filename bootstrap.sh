#!/bin/bash
set -euo pipefail
set -x
email="$1"; shift

echo 'Initializing AUR Ansible module'
git clone https://github.com/kewlfft/ansible-aur.git ~/.ansible/plugins/modules/aur

echo 'Upgrading system packages, installing bootstrap packages...'
sudo -S pacman -Syu
sudo -S pacman -S ansible lastpass-cli openssh python3 keychain xorg-xvidtune

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

echo 'Importing Xyne AUR GPG key to install Bauerbill'
gpg --recv-keys 1D1F0DC78F173680

echo 'Bootstrap done!'
