export PATH=$HOME/.local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
#export TERM="xterm-256color"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="aditya"
source $ZSH/oh-my-zsh.sh
plugins=(git)
#ZSH_THEME="arrow"
export TERMINAL="kitty"
export EDITOR="lvim" 
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.oh-my-zsh/custom/plugins/auto-notify/auto-notify.plugin.zsh
#------------------------------------------
#export nnn

#export NNN_COLORS='5'
export NNN_FIFO="/tmp/nnn.fifo"

#export NNN_COLORS='6'

#export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'

export NNN_PLUG='f:finder;o:preview-tabbed;p:mocplay;d:diffs;t:nmount;v:imgview'
bindkey -v

#my aliases
alias s="startx"
alias ii="ip -c a"
alias ww="nitrogen --set-zoom-fill --random ~/Wallpaper --save"
alias o="open"
alias f="exa --icons --long"
alias x="chmod +x"
alias nf="neofetch"
alias c="clear"
alias q="exit"
alias app="sudo apt update && sudo apt upgrade -y"
alias i="sudo apt install"
alias re="sudo apt remove"
alias sto="cd /storage/emulated/0"
alias ll.="ls -Sal"
alias cl="du -ha | sort -k1hr | head -n 60"
alias n="nnn -de"
alias rr="rm -rf"
alias v="vim"
alias h="htop"
alias sys="sudo systemctl"
alias vv="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
#------------------------------------------

# SSH Server Connections

# linux (Arch)
#alias arch='ssh UNAME@IP -i ~/.ssh/id_rsa.DEVICE'

# linux sftp (Arch)
#alias archfs='sftp -i ~/.ssh/id_rsa.DEVICE UNAME@IP'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
