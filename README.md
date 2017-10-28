Development environment managed with Ansible.

## First run
 * **Dell XPS 15 9560** Switch SATA from Intel RAID to AHCI in BIOS
 * Install the latest Ubuntu desktop

```
# Bootstrap
sudo pacman -S git
git clone https://github.com/abesto/ansible-devenv
cd ansible-devenv
./bootstrap.sh $EMAIL

# SSH agent for initial run (later handled in Xsession)
eval $(keychain --eval)
ssh-add
./apply.sh $SITE  # where a site is the basename of one of the .email files in the repo root

# manually log in to dropbox
dropbox start -i

# manually log in to keybase, add private key to GPG
keybase login
keybase pgp export -s | gpg --allow-secret-key-import --import
```
