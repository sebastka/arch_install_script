#!/bin/sh

## Variables
DISK="/dev/sda"
BOOT="${DISK}2"
SWAP="${DISK}5"
ROOT="${DISK}6"

## Set up install system
read -n 1 -p "Network and time..."
#loadkeys no-latin1
#wifi-menu
timedatectl set-ntp true

# Setting up mirrors
read -n 1 -p "Setting up mirrors and repos..."
pacman -S reflector
reflector --country Norway --country Sweden --country Denmark --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
echo "##Place first\n#[kde-unstable]\n#Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
echo "## curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg\n# /arch/dev or /arch/stable\n[sublime-text]\nServer = https://download.sublimetext.com/arch/dev/x86_64" >> /etc/pacman.conf
vim /etc/pacman.conf
pacman -Sy

## Get script
read -n 1 -p "Getting script..."
pacman -S git
git clone https://github.com/sebastka/arch_install_script.git /root
chmod +x /root/arch_install_script/2.sh /root/arch_install_script/3.sh

## Partitionning
read -n 1 -p "Partitioning"
fdisk $DISK
mkfs.btrfs $ROOT
mkswap $SWAP
swapon $SWAP

## Mounting and deleting existing GRUB
read -n 1 -p "Mounting new system fs and deleting existing GRUB..."
mount $ROOT /mnt
mkdir /mnt/boot
mount $BOOT /mnt/boot
rm -rI /mnt/boot/EFI/GRUB /mnt/boot/grub /mnt/boot/initramfs-linux-fallback.img /mnt/boot/initramfs-linux.img /mnt/boot/intel-ucode.img /mnt/boot/vmlinuz-linux

## Installing base system
read -n 1 -p "Installing base system..."
pacstrap /mnt base base-devel linux linux-firmware zsh networkmanager vim nano man-pages man-db intel-ucode os-prober grub efibootmgr ntfs-3g wget reflector
genfstab -U /mnt >> /mnt/etc/fstab

for file in "/etc/pacman.conf" "/etc/pacman.d/mirrorlist"
do
    mv "/mnt{$file}" "/mnt{$file}.bak"
    cp "{$file}" "/mnt{$file}"
done

## Chrooting into new system
read -n 1 -p "Chrooting..."
mv -t /mnt/root /root/arch_install_script/2.sh /root/arch_install_script/3.sh /root/arch_install_script/.zshrc /root/arch_install_script/.p10k.zsh
arch-chroot /mnt sh /root/2.sh
rm /mnt/root/2.sh

## umount
read -n 1 -p "Umounting..."
umount /mnt/boot
umount /mnt