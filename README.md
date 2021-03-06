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
git checkout arch
./bootstrap.sh $EMAIL

# SSH agent for initial run (later handled in Xsession)
eval $(keychain --eval)
ssh-add
# a site is the basename of one of the .email files in the repo root
# update the screen resolution as appropriate; need to hint here because we're not yet in the graphical environment
env X_WIDTH=2560 X_HEIGHT=1440 ./apply.sh $SITE

# manually log in to keybase, add private key to GPG
keybase login
keybase pgp export -s | gpg --allow-secret-key-import --import

# Install MS fonts, as described in https://wiki.archlinux.org/index.php/Microsoft_fonts
mkdir /mnt/windows
mount /dev/sdXX /mnt/windows
mkdir /usr/share/fonts/WindowsFonts
cp -r /mnt/windows/Windows/Fonts/ /usr/share/fonts/WindowsFonts
chmod 755 /usr/share/fonts/WindowsFonts/*
fc-cache -f
```

## As VirtualBox guest

```
pacman -S virtualbox-guest-modules virtualbox-guest-modules-arch
systemctl start vboxservice
systemctl enable vboxservice
VBoxClient-all
echo VBoxClient-all > ~/.xprofile.d/99-vbox-guest
```

## System upgrade

Pacman and AUR packages are _not_ upgraded by `ansible` runs. Packages are built by `ansible` in `~/aur` before installation of `yay`, and then through `yay`. Upgrading _everything_ is done through [`topgrade`](https://github.com/r-darwish/topgrade):

```
topgrade
```
