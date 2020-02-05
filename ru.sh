#!/bin/bash

echo '>> Russification...'
loadkeys ru
setfont cyr-sun16
echo -e 'KEYMAP=ru\nFONT=cyr-sun16\n' > /etc/vconsole.conf

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

export LANG=ru_RU.UTF-8

#echo
#echo -e 'Для завершения руссификации введите'
#echo -e 'export LANG=ru_RU.UTF-8'
