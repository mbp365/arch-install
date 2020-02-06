#!/bin/bash

echo '>> Подключение дисков'
swapon /dev/sda1
mount /dev/sda3 /mnt
mount /dev/sda2 /mnt/boot
mount /dev/sda4 /mnt/home

echo
echo '>> Подключение разделов'
echo 'arch-chroot /mnt'
