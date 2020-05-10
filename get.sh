#!/bin/sh

## Get script
read -n 1 -p "Getting script..."
pacman -S git
git clone https://github.com/sebastka/arch_install_script.git /root

sh /root/arch_install_script/1.sh

exit 0