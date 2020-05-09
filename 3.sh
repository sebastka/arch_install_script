#!/bin/sh

# pikaur
read -n 1 -p "pikaur..."
mkdir builds builds/pikaur
cd ~/builds/pikaur
curl https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pikaur >> PKGBUILD
makepkg -csi
cd ~

pikaur -Syu
pikaur -S gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid ttf-ibm-plex ttf-liberation ttf-meslo-nerd-font-powerlevel10k powerline-fonts

# zsh setup
read -n 1 -p "zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git .oh-my-zsh/custom/themes/powerlevel10k
mkdir -p ~/.cache/zsh

read -n 1 -p "Install KDE and apps"
pikaur -S mesa xorg plasma-meta kde-applications-meta plasma-nm sddm vlc
pikaur -S firefox-beta-bin code nordvpn-bin fzf

exit 0