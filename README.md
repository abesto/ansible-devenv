Development environment managed with Ansible.

## First run
 * **Dell XPS 15 9560** Switch SATA from Intel RAID to AHCI in BIOS
 * Install the latest Ubuntu desktop

```
sudo apt-get install -y git python-pip
git clone https://github.com/abesto/ansible-devenv
cd ansible-devenv
./bootstrap.sh $EMAIL
./apply.sh $SITE  # where a site is one of the .yml files in the repo root, without the .yml suffix
# manually log in to dropbox
dropbox start -i
# manually log in to keybase, add private key to GPG
keybase login
keybase pgp export -s | gpg --allow-secret-key-import --import
```
