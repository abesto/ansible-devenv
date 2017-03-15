#!/bin/bash
set -euo pipefail
email="$1"; shift

echo 'Upgrading system packages...'
sudo apt-get update
sudo apt-get upgrade

echo 'Installing packages required to build ansible, lastpass-cli from source...'
sudo apt-get install -y virtualenv libssl-dev cmake

echo 'Creating virtualenv with Ansible snapshot (for lastpass integration)...'
virtualenv virtualenv
set +u; . virtualenv/bin/activate; set -u
sudo pip install 'git+https://github.com/ansible/ansible#egg=ansible'  # replace with ansible from apt once lastpass lookup plugin is released

echo 'Installing lastpass-cli from source (Xenial has a broken, old version)...'
mkdir -p ~/lastpass
pushd ~/lastpass
wget https://github.com/lastpass/lastpass-cli/archive/v1.1.2.tar.gz
tar -xzf v1.1.2.tar.gz
cd lastpass-cli-1.1.2
cmake .
make
sudo make install install-doc
popd

echo 'LastPass login...'
lpass login "$email"

echo 'Ansible bootstrap.yml run...'
ansible-playbook bootstrap.yml -i inventory --ask-become-pass "$@"

echo 'Switch from https origin on this git repo to SSH'
git remote rm origin
git remote add origin git@github.com:abesto/ansible-devenv.git
git fetch
git branch -u origin/master

echo 'Bootstrap done!'
