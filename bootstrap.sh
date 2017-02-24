#!/bin/bash
set -euo pipefail
email="$1"; shift

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y git virtualenv lastpass-cli libssl-dev

virtualenv virtualenv
set +u; . virtualenv/bin/activate; set -u
sudo pip install 'git+https://github.com/ansible/ansible#egg=ansible'  # replace with ansible from apt once lastpass lookup plugin is released

lpass login "$email"
ansible-playbook bootstrap.yml -i inventory --ask-become-pass "$@"
git remote rm origin
git remote add origin git@github.com:abesto/ansible-devenv.git
git fetch
git branch -u origin/master
