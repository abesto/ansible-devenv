Development environment managed with Ansible – ArchLinux alternative.

## First run
 * Install ArchLinux
 * Configure networking
 * Create user, `visudo` so that the user can `sudo`
 * Customize keyboard layout if desired (eg. `localectl set-x11-keymap us pc104 colemak && localectl set-keymap colemak`)
 * Switch to the user, then

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

## As VirtualBox guest

```
pacman -S virtualbox-guest-modules-arch
systemctl start vboxservice
systemctl enable vboxservice
VBoxClient-all
echo VBoxClient-all > ~/.xprofile.d/99-vbox-guest
```

## System upgrade

Pacman and AUR packages are _not_ upgraded by `ansible` runs. Packages are build by `ansible` in `~/aur`, but are upgraded with `bauerbill`:

```
bb-wrapper -Syu --aur
```
