# arch_install_script

* [ArchWiki - Dell XPS 13 (9343)](https://wiki.archlinux.org/index.php/Dell_XPS_13_(9343))
* [ArchWiki - Installation guide](https://wiki.archlinux.org/index.php/installation_guide)
* [ArchWiki - General Recommendations](https://wiki.archlinux.org/index.php/General_recommendations)

Selects the best mirrors from Norway, Sweden and Denmark. Activates kde-unstable, testing, community-testing.

## Variables (1.sh)
* DISK=/dev/sda
* BOOT="/dev/sda2"
* SWAP="/dev/sda5"
* ROOT="/dev/sda6"

## Variables (2.sh)
* USER=""
* DISK="/dev/sda"
* WINDOWS="/dev/sda4"
* HOSTNAME="archpc"

## Packages
* base base-devel linux linux-firmware intel-ucode os-prober grub efibootmgr ntfs-3g
* networkmanager vim nano man-pages man-db wget reflector
* pikaur zsh
* gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid ttf-ibm-plex ttf-liberation ttf-meslo-nerd-font-powerlevel10k powerline-fonts
* mesa xorg plasma-meta kde-applications-meta plasma-nm sddm vlc
* firefox-beta-bin code nordvpn-bin fzf

... and Oh My Zsh + Powerlevel10k (remember to change console font to MesloLGS NF Regular)

## Services
* NetworkManager
* sddm
* nordvpnd