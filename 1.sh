#!/bin/sh

## Marks as executable for all
chmod 755 /root/arch_install_script/*.sh

## Variables
source /root/arch_install_script/vars.sh

## Set up install system
read -n 1 -p "Network and time..."
loadkeys no-latin1
iwctl

read -n 1 -p "Testing internet connection..."
ping archlinux.org
read -n 1 -p "Continue if it worked"

timedatectl set-ntp true

# Setting up mirrors
read -n 1 -p "Setting up mirrors and repos..."
pacman -S reflector
reflector --country ${COUNTRY[0]} --country ${COUNTRY[1]} --country ${COUNTRY[2]} --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist


cat <<'EOF' >> /etc/pacman.conf
## kde-unstable | Place first
#[kde-unstable]
#Include = /etc/pacman.d/mirrorlist

## Sublime-text | stable or dev
## Key: curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
#[sublime-text]
#Server = https://download.sublimetext.com/arch/stable/x86_64
EOF

vim /etc/pacman.conf
pacman -Sy

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
pacstrap /mnt base base-devel linux linux-firmware fish iwd vim nano man-pages man-db intel-ucode os-prober grub efibootmgr ntfs-3g wget reflector git
genfstab -U /mnt >> /mnt/etc/fstab

for file in "/etc/pacman.conf" "/etc/pacman.d/mirrorlist"
do
    mv "/mnt{$file}" "/mnt{$file}.bak"
    cp "{$file}" "/mnt{$file}"
done

## Chrooting into new system
read -n 1 -p "Chrooting..."
cp -a /root/arch_install_script /mnt/root
arch-chroot /mnt sh /root/2.sh
rm -rf /mnt/root/arch_install_script

## umount
read -n 1 -p "Umounting..."
umount /mnt/boot
umount /mnt

exit 0