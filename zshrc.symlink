export ZSH=/home/atsushi/.oh-my-zsh
export PATH="/home/linuxbrew/.linuxbrew/bin:/usr/bin:/bin:/usr/sbin:/sbin:/home/atsushi/.local/bin:$PATH"
export VISUAL=vim
export EDITOR="$VISUAL"

ZSH_THEME="agnoster"
plugins=(git ruby docker zsh-syntax-highlighting zsh-autosuggestions gpg-agent) # All plugins at ~/.oh-my-zsh/plugins/*
source $ZSH/oh-my-zsh.sh

export SSH_KEY_PATH="~/.ssh/id_rsa"
#keychain ~/.ssh/id_rsa.pub #>/dev/null 2>/dev/null
#source $HOME/.keychain/yakiniku-sh

eval `keychain --eval --agents gpg,ssh id_rsa` # For keychain
#eval `keychain --eval id_rsa` # For keychain
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'


# redefine prompt_context for hiding user@hostname
# prompt_context () { }

# Docker
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# =====================================
# Alias

calc () {
    bc -l <<< "$@"
}

dic () {
  dict "$1" | less
}

# Control dotfiles in git
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Courses
# 2018s
alias cs313='cd ~/Dropbox/UBC/uni_text/2018w/CPSC313'
alias cs404='cd ~/Dropbox/UBC/uni_text/2018w/CPSC404'
alias comm395='cd ~/Dropbox/UBC/uni_text/2018w/COMM395'
alias comm394='cd ~/Dropbox/UBC/uni_text/2018w/COMM394'
alias nvd='cd ~/Dropbox/UBC/uni_text/2018w/COMM466'
# 2019
alias cs415='cd ~/Dropbox/UBC/uni_text/2019w/CPSC415'
alias comm335='cd ~/Dropbox/UBC/uni_text/2019w/COMM335'
alias comm393='cd ~/Dropbox/UBC/uni_text/2019w/COMM393'
alias comm436='cd ~/Dropbox/UBC/uni_text/2019w/COMM436'

alias calc=calc
alias cdu='cd ~/ubyssey-dev/ubyssey.ca && source ../bin/activate'
alias cdd='cd ~/ubyssey-dev/dispatch && source ../bin/activate'
alias cdus='cd ~/ubyssey-dev/ubyssey.ca && source ../bin/activate && python manage.py runserver'
alias cdj='cd ~/p/src/github.com/jumbosushi'
alias cdtgo='cd /tmp/go'
alias ctagsconfig="vim ~/.ctags"
alias dbundle='~/p/bundler/bin/bundle'
alias dedit="vim Dockerfile"
alias dic=dic
alias docc="docker-compose"
alias do_ctags="ctags -R ."
alias docker-cb="docker-compose build"
alias docker-cu="docker-compose up"
alias docker-clean="docker rm \$(docker ps -a -q -f status=exited)"
alias docker-stop-all="docker stop $(docker ps -q)"
alias edit_today="geeknote edit --note $(date -I)"
alias exa="/usr/bin/exa-linux-x86_64"
alias gcm="git commit -m"
alias gl="git log"
alias gpr="ggpull --rebase"
alias grep_dir="grep -R $1 ."
alias gs="git status"
alias gstaa="stash save --include-untracked"
alias how_big="du -hs $1"
alias ipm="/usr/lib/inkdrop/resources/app/ipm/bin/ipm"
alias j="autojump"
alias journal="geeknote create --title $(date -I) --tag journal --notebook Daily"
alias lc="leetcode"
alias ngrok="/usr/bin/ngrok"
alias notes="cd ~/vimwiki/notes"
alias open="nautilus $1"
alias pi_ssh="ssh pi@192.168.1.52"
alias pp="cd ~/p"
alias pm="python manage.py"
alias rbenv_update="cd ~/.rbenv/plugins/ruby-build && git pull && cd -"
alias remove_js="find . -name '*.js' -type f  -delete"
alias remove_swo="find . -name \*.swo -type f -delete"
alias remove_swp="rm -rf ~/.local/share/nvim/swap/*"
alias replace_all="find .  f -exec sed -i 's/$1/$2/g; {} \;"
alias restart_network="sudo systemctl restart network-manager.service"
# After ls, run 'sudo cat' with the wifi name
alias show_wifi_pass="/etc/NetworkManager/system-connections && ls -a"
alias tmp="cd /tmp"
alias tgo="vim /tmp/go/main.go"
alias tmd="vim /tmp/temp.md"
alias save-battery="sudo tlp start && sudo powertop --auto-tune"
alias sai="sudo apt install $1"
alias sau="sudo apt update"
alias setx="export TERM=xterm-256color"
alias ssh-ubc="ssh -X r6v9a@thetis.ugrad.cs.ubc.ca"
alias tmuxconfig="vim ~/.tmux.conf"
alias tree="tree -a -I '.git|node_modules|tmp|public'"
alias ubc="cd ~/Dropbox/UBC/uni_text/2018w/" # update next term
alias ubyssey_dispatch="cd ~/p/ubyssey/dispatch/dispatch/static/manager/src"
alias undo_last_commit="git reset HEAD^"
alias update="sudo apt update; sudo apt -y dist-upgrade; sudo apt -y autoremove"
alias vim_swap="cd ~/.local/share/nvim/swap"
alias vmd="vim /tmp/test.md"
alias vimconfig="vim ~/.vimrc"
alias wifi_bar='nm-appalet'
alias wiki="cd ~/Dropbox/wiki"
alias wut="$1 --help | grep $2"
alias zshconfig="vim ~/.zshrc"
alias ubcwifi=" cd ~/ubcsecure && ./Cloudpath-x64 && cd -"

# Run git status on blank enter
# https://tellme.tokyo/post/2016/12/20/git-tips/
do_enter() {
    if [[ -n $BUFFER ]]; then
        zle accept-line
        return $status
    fi

    echo
    if [[ -d .git ]]; then
        if [[ -n "$(git status --short)" ]]; then
            git status
        fi
    else
        # do nothing
        :
    fi

    zle reset-prompt
}
zle -N do_enter
bindkey '^m' do_enter

# =====================================
# Language config

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# nvm
export NVM_DIR="/home/atsushi/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export NODE_PATH=$NODE_PATH:/home/atsushi/.nvm/versions/node/v6.7.0/lib/node_modules

# Go
export GOPATH=$HOME/p
source ~/.tmuxinator.zsh
export DISABLE_AUTO_TITLE=true
export PATH=$PATH:$GOPATH/bin

# fortune | pokemonsay
export PATH=$PATH:/usr/local/go/bin


# ==================================
# Use vim keybind
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins '\C-e' end-of-line
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward


# fzf + ag configuration
_has(){
    command type "$1" > /dev/null 2>&1
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='
  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi

# added by travis gem
[ -f /home/atsushi/.travis/travis.sh ] && source /home/atsushi/.travis/travis.sh

# tiny-care-terminal
export TTC_BOTS='tinycarebot,selfcare_bot,magicrealismbot'
export TTC_SAY_BOX='parrot'
export TTC_REPOS='~/p/ubcbooker,~/ubyssey-dev/ubyssey.ca,~/ubyssey-dev/dispatch'
export TTC_GITBOT='gitlog'
export TTC_WEATHER='Vancouver'
export TTC_APIKEYS=false
export TTC_UPDATE_INTERVAL=20

# Google Cloud
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
# autojump
. /usr/share/autojump/autojump.sh

