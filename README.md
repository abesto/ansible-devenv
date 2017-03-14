Development environment managed with Ansible.

## First run
 * **Dell XPS 15 9560** Switch SATA from Intel RAID to AHCI in BIOS
 * Install Ubuntu Xenial Desktop

```
sudo apt-get install -y git python-pip
git clone https://github.com/abesto/ansible-devenv
cd ansible-devenv
./bootstrap.sh $EMAIL
./apply.sh
dropbox start -i  # needs manual setup, can't find a way to automate
dropbox autostart y
```
