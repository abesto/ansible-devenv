Development environment managed with Ansible.

## First run
 * **Dell XPS 15 9560** Switch SATA from Intel RAID to AHCI in BIOS
 * Install Ubuntu Yakkety Desktop

```
sudo apt-get install -y git python-pip
git clone https://github.com/abesto/ansible-devenv
cd ansible-devenv
./bootstrap.sh $EMAIL
./apply.sh
# manually log in to dropbox
dropbox start -i
# manually log in to keybase, add private key to SSH
keybase login
keybase pgp export -s | gpg --allow-secret-key-import --import
```
