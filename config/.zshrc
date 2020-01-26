 # Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/user/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Alias
alias ls='ls --color=auto'
alias mkl='sudo mkinitcpio -p linux'
alias pacman='sudo pacman'
alias pmc='sudo pacman -Rsnc $(pacman -Qdtq)'

# Functions
# Функция установки из aur
#Входящие параметры $1 наименование пакета
function aur {
	cd /tmp
	git clone https://aur.archlinux.org/$1.git
	cd $1
	makepkg -si
	cd ..
	rm -rf $1
}

# Editor
export VISUAL=vim
export EDITOR="$VISUAL"
