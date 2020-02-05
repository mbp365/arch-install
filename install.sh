#!/bin/bash

echo '--------------------------------------------------------------------------------'
echo '|                               Config Install                                 |'
echo '--------------------------------------------------------------------------------'
pass=$0

# Функция установки из aur
#Входящие параметры $1 наименование пакета
function aur {
	cd /tmp
	git clone https://aur.archlinux.org/$1.git
	chown -R $username:users /tmp/$1
	chown -R $username:users /tmp/$1/PKGBUILD
	cd $1
	echo $pass | makepkg -si --noconfirm
	cd ..
	rm -rf $1
}

echo '--------------------------------------------------'
echo '|           Установка Display Manager            |'
echo '--------------------------------------------------'
# раскомментировать блок SDDM или LXDM
echo '>> Установка sddm'
echo $pass | sudo pacman -Sy sddm sddm-kcm --noconfirm
systemctl enable sddm

echo '>> Настройка SDDM для xrandr'
echo $pass | sudo pacman -Sy xorg-xrandr --noconfirm
echo 'xrandr --auto' >> /usr/share/sddm/scripts/Xsetup
echo 'xrandr --dpi 75' >> /usr/share/sddm/scripts/Xsetup

echo '>> Установка настройки сети'
echo $pass | sudo pacman -Sy networkmanager samba --noconfirm
systemctl enable NetworkManager

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
echo $pass | sudo pacman -Sy plasma-meta kdebase packagekit-qt5 kde-gtk-config --noconfirm
echo '>  Дополнительный софт для KDE'
echo $pass | sudo pacman -Sy konsole partitionmanager ark spectacle okular kcalc --noconfirm
echo $pass | sudo pacman -Sy aspell aspell-ru --noconfirm
echo $pass | sudo pacman -Rsnc konqueror kwrite --noconfirm

echo '>> Bluetooth pulseaudio и alsa поддержка звука'
echo $pass | sudo pacman -Sy bluez bluez-utils bluedevil pulseaudio-bluetooth alsa-utils pulseaudio-equalizer-ladspa --noconfirm
systemctl enable bluetooth.service

#echo 'XFCE'
#echo $pass | sudo pacman -Sy xfce4 xfce4-goodies --noconfirm

echo '--------------------------------------------------'
echo '|        Установка дополнительного софта         |'
echo '--------------------------------------------------'

echo '>> Настройка папок пользователя'
echo $pass | sudo pacman -Sy xdg-user-dirs --noconfirm

echo $pass | sudo pacman -Syu
echo $pass | sudo pacman -Sy git --noconfirm

echo '>> Установка pacaur'
aur auracle-git
aur pacaur

echo '>> Установка микрокода для aic94xx и wd719x'
aur aic94xx-firmware
aur wd719x-firmware

mkinitcpio -p linux

echo '>> Установка octopi'
aur alpm_octopi_utils
aur octopi

echo '>> Установка Double Commander'
echo $pass | sudo pacman -Sy doublecmd-qt5 --noconfirm

echo '>> Установка Firewall'
echo $pass | sudo pacman -Sy ufw gufw --noconfirm
systemctl enable ufw.service

echo '>> Установка LibreOffice'
echo $pass | sudo pacman -Sy libreoffice-fresh libreoffice-fresh-ru --noconfirm

echo '>> Установка firefox'
echo $pass | sudo pacman -Sy firefox firefox-i18n-ru flashplugin --noconfirm

echo '>> Установка почтового клиента'
echo $pass | sudo pacman -Sy thunderbird thunderbird-i18n-ru --noconfirm

echo '>> Разработка ПО'
echo $pass | sudo pacman -Sy qtcreator cmake kdevelop --noconfirm

echo '>> VirtualBox'
echo $pass | sudo pacman -Sy virtualbox virtualbox-ext-vnc virtualbox-sdk virtualbox-guest-iso --noconfirm
modprobe vboxdrv

echo '>> Читалки, просмотр фото, музыки и прочее'
echo '> Установка программ для обработки с музыки и видео'
echo $pass | sudo pacman -Sy vlc cheese --noconfirm
echo $pass | sudo pacman -Sy audacious audacity --noconfirm
echo $pass | sudo pacman -Sy kdenlive --noconfirm

echo '> Установка программ для обработки графики'
echo $pass | sudo pacman -Sy gimp --noconfirm
echo $pass | sudo pacman  -Sy blender --noconfirm

echo '> Установка qbittorrent'
echo $pass | sudo pacman -Sy qbittorrent --noconfirm

echo '>Прочее'
echo $pass | sudo pacman -Sy neofetch baobab okteta --noconfirm
echo $pass | sudo pacman -Sy gwenview --noconfirm

echo '>> Установка wine'
echo $pass | sudo pacman -Sy mono --noconfirm
echo $pass | sudo pacman -Sy wine wine-mono wine-gecko winetricks --noconfirm
aur dxvk-bin
#winecfg
#setup_dxvk install
echo $pass | sudo pacman -Sy vkd3d lib32-vkd3d --noconfirm

echo '>> Ставим шрифты'
echo $pass | sudo pacman -Sy ttf-liberation ttf-dejavu --noconfirm
aur ttf-ms-fonts
aur ttf-tahoma

echo '>> Отчистка диска'
echo $pass | sudo pacman -Scc --noconfirm
