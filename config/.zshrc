# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/like/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT='%F{blue}%n%f@%F{248}%m%f %F{white}%B%~%b%f # '
