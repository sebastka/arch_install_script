#!/bin/sh

USER=""
DISK="/dev/sda"
WINDOWS="${DISK}4"
HOSTNAME="archpc"

# Users
read -n 1 -p "Users..."
passwd
visudo
useradd -D -s/bin/zsh
useradd -m -G wheel $USER
passwd $USER

# Locale
read -n 1 -p "Time and locale..."
ln -sf /usr/share/zoneinfo/Europe/Oslo /etc/localtime
hwclock --systohc
vim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=no-latin1" >> /etc/vconsole.conf

# Host
read -n 1 -p "Host..."
echo $HOSTNAME >> /etc/hostname
vim /etc/hosts

# GUI and toolks
read -n 1 -p "DE and tools..."
mv -t "/home/${USER}/" /root/3.sh /root/.zshrc /root/.p10k.zsh
chown $USER:$USER "/home/${USER}/3.sh" "/home/${USER}/.zshrc" "/home/${USER}/.p10k.zsh"
chmod +x "/home/${USER}/3.sh"
su -c "sh /home/${USER}/3.sh" $USER
rm "/home/${USER}/3.sh"

# Set SDDM keyboard
localectl set-x11-keymap no

## Bootloader
read -n 1 -p "Bootloader..."
mount $WINDOWS /mnt
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
umount /mnt

## Enable services
read -n 1 -p "Enabling services..."
systemctl enable NetworkManager
systemctl enable sddm
systemctl enable nordvpnd

## Exit chroot and umount
read -n 1 -p "Exit..."
exit 0