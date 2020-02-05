#!/bin/bash

echo '--------------------------------------------------------------------------------'
echo '|                               Config Install                                 |'
echo '--------------------------------------------------------------------------------'
pass=$1

# Функция установки из aur
#Входящие параметры $1 наименование пакета
function aur {
	cd /tmp
	git clone https://aur.archlinux.org/$1.git
	cd $1
	echo $pass | makepkg -si --noconfirm
	cd ..
	rm -rf $1
}

echo '--------------------------------------------------'
echo '|              Установка драйверов               |'
echo '--------------------------------------------------'

echo '>> Установка xorg и mesa'
echo $pass | sudo pacman -Sy xorg-server xorg-xinit mesa --noconfirm

#mkdir -p /etc/X11/xorg.conf.d
#cd /etc/X11/xorg.conf.d/

#echo '>> Установка поддержки файловых систем NTFS exFAT'
#pacman -Sy ntfs-3g exfat-utils --noconfirm

echo '>> VirtualBox'
echo $pass | sudo pacman -Sy virtualbox-guest-utils virtualbox-guest-dkms --noconfirm
echo $pass | sudo systemctl enable vboxservice 

echo '--------------------------------------------------'
echo '|           Установка Display Manager            |'
echo '--------------------------------------------------'
# раскомментировать блок SDDM или LXDM
echo '>> Установка sddm'
echo $pass | sudo pacman -Sy sddm sddm-kcm --noconfirm
echo $pass | sudo systemctl enable sddm

#echo '>> Настройка SDDM для xrandr'
#echo $pass | sudo pacman -Sy xorg-xrandr --noconfirm
#echo 'xrandr --auto' >> /usr/share/sddm/scripts/Xsetup
#echo 'xrandr --dpi 75' >> /usr/share/sddm/scripts/Xsetup

echo '>> Установка настройки сети'
echo $pass | sudo pacman -Sy networkmanager --noconfirm
echo $pass | sudo systemctl enable NetworkManager

echo '--------------------------------------------------'
echo '|         Установка Desktop Environment          |'
echo '--------------------------------------------------'
#echo '>> Cinnamon'
#echo $pass | sudo pacman -Sy cinnamon cinnamon-translations --noconfirm
#echo $pass | sudo pacman -Sy gnomme-terminal

#echo '>> Deepin'
#echo $pass | sudo pacman -Sy deepin --noconfirm

echo '>> KDE Plasma'
echo $pass | sudo pacman -Sy phonon-qt5-vlc --noconfirm
echo $pass | sudo pacman -Sy plasma-meta kdebase packagekit-qt5 --noconfirm
echo '>  Дополнительный софт для KDE'
echo $pass | sudo pacman -Sy konsole partitionmanager ark spectacle okular --noconfirm
echo $pass | sudo pacman -Sy aspell aspell-ru --noconfirm
echo $pass | sudo pacman -Rsnc konqueror kwrite --noconfirm

#echo 'XFCE'
#echo $pass | sudo pacman -Sy xfce4 xfce4-goodies --noconfirm

echo '--------------------------------------------------'
echo '|        Установка дополнительного софта         |'
echo '--------------------------------------------------'

echo '>> Настройка папок пользователя'
echo $pass | sudo pacman -Sy xdg-user-dirs --noconfirm

echo $pass | sudo pacman -Syu --noconfirm
echo $pass | sudo pacman -Sy git --noconfirm

echo '>> Установка pacaur'
aur auracle-git
aur pacaur

#echo '>> Установка микрокода для aic94xx и wd719x'
#aur aic94xx-firmware
#aur wd719x-firmware

sudo mkinitcpio -p linux

#echo '>> Установка octopi'
#aur alpm_octopi_utils
#aur octopi

#echo '>> Установка Firewall'
#echo $pass | sudo pacman -Sy ufw gufw --noconfirm
#echo $pass | sudo systemctl enable ufw.service

#echo '>> Установка wine'
#echo $pass | sudo pacman -Sy wine wine-mono wine_gecko winetricks --noconfirm
#aur dxvk-bin
#winecfg
#setup_dxvk install
#echo $pass | sudo pacman -Sy vkd3d lib32-vkd3d --noconfirm

echo '>> Установка firefox'
echo $pass | sudo pacman -Sy firefox firefox-i18n-ru --noconfirm

#echo '>> Установка почтового клиента'
#echo $pass | sudo pacman -Sy thunderbird thunderbird-i18n-ru --noconfirm

#echo '>> Установка VLC'
#echo $pass | sudo pacman -Sy vlc cheese --noconfirm

#echo '>> Установка qbittorrent'
#echo $pass | sudo pacman -Sy qbittorrent --noconfirm

#echo '>> Читалки, просмотр фото, музыки и прочее'
echo $pass | sudo pacman -Sy neofetch baobab --noconfirm
#echo $pass | sudo pacman -Sy gwenview audacious --noconfirm

echo '>> Ставим шрифты'
echo $pass | sudo pacman -Sy ttf-liberation ttf-dejavu --noconfirm
aur ttf-ms-fonts
aur ttf-tahoma

exit
