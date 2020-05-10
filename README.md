# arch_install_script

* [ArchWiki - Dell XPS 13 (9343)](https://wiki.archlinux.org/index.php/Dell_XPS_13_(9343))
* [ArchWiki - Installation guide](https://wiki.archlinux.org/index.php/installation_guide)
* [ArchWiki - General Recommendations](https://wiki.archlinux.org/index.php/General_recommendations)

## Variables
* DISK=/dev/sda
* BOOT="/dev/sda2"
* SECOND_OS="/dev/sda4"
* SWAP="/dev/sda5"
* ROOT="/dev/sda6"
* USER=""
* HOSTNAME="archpc"
* COUNTRY=(Norway Sweden Denmark)

## Packages
* base base-devel linux linux-firmware intel-ucode os-prober grub efibootmgr ntfs-3g
* man-pages man-db networkmanager vim curl reflector
* pikaur zsh git nano wget
* gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid ttf-ibm-plex ttf-liberation ttf-meslo-nerd-font-powerlevel10k powerline-fonts
* mesa xorg plasma-meta kde-applications-meta plasma-nm sddm vlc
* firefox-beta-bin code nordvpn-bin fzf

## Services
* NetworkManager
* sddm
* nordvpnd

## Features
* Choose additionnal mirrors: kde-unstable, sublime-text;
* Selects automatically the best mirrors from three countries. Default: Norway, Sweden and Denmark;
* Oh My Zsh + Powerlevel10k (remember to change console font to MesloLGS NF Regular).