Development environment managed with Ansible.

First, take a new minimal Ubuntu system (https://help.ubuntu.com/community/Installation/MinimalCD). Install manually. Then:

```
sudo apt-get install -y git
git clone https://github.com/abesto/ansible-devenv
cd ansible-devenv
./bootstrap.sh $EMAIL
./apply.sh
```
