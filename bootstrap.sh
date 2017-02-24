#!/bin/bash
set -euo pipefail
email="$1"

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install ansible lastpass-cli
lpass login "$email"
git remote rm origin
git remote add origin git@github.com:abesto/ansible-devenv.git
git fetch
git branch -u origin/master
