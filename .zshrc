export ZSH=/home/atsushi/.oh-my-zsh
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/home/atsushi/.local/bin:$PATH"
export VISUAL=vim
export EDITOR="$VISUAL"

ZSH_THEME="agnoster"
plugins=(git ruby docker zsh-syntax-highlighting zsh-autosuggestions) # All plugins at ~/.oh-my-zsh/plugins/*
source $ZSH/oh-my-zsh.sh

export SSH_KEY_PATH="~/.ssh/dsa_id"
eval `keychain --eval id_rsa` # For keychain

# redefine prompt_context for hiding user@hostname
# prompt_context () { }

# Docker
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# =====================================
# Alias

alias ....="cd ../.."
alias do_ctags="ctags -R ."
alias gcm="git commit -m"
alias grep_dir="grep -R $1 ."
alias ngrok="/bin/ngrok"
alias open="nautilus $1"
alias pi_ssh="ssh pi@192.168.1.52"
alias remove_swp="rm -rf ~/.local/share/nvim/swap/*"
alias remove_swo="find . -name \*.swo -type f -delete"
alias restart_network="sudo systemctl restart network-manager.service"
alias ubyssey_dispatch="cd ~/p/ubyssey/dispatch/dispatch/static/manager/src"
alias undo_last_commit="git reset HEAD^"
alias update="sudo apt-get update; sudo apt-get -y dist-upgrade;sudo apt -y autoremove"
alias vimconfig="vim ~/.vimrc"
alias wifi_bar='nm-appalet'
alias wut="$1 --help | grep $2"
alias zshconfig="vim ~/.zshrc"
alias ctagsconfig="vim ~/.ctags"
alias tmuxconfig="vim ~/.tmux.conf"
alias how_big="du -hs $1"
alias tree="tree -a -I '.git|node_modules|tmp|public'"
alias notes="cd ~/vimwiki/notes"
alias wiki="cd ~/Dropbox/wiki"
alias journal="geeknote create --title $(date -I) --tag journal --notebook Daily"
alias edit_today="geeknote edit --note $(date -I)"
alias pp="cd ~/p"
alias dedit="vim Dockerfile"
alias docker-cb="docker-compose build"
alias docker-cu="docker-compose up"
alias gl="git log"
alias vim_swap="cd ~/.local/share/nvim/swap"
alias gs="git status"
alias gpr="ggpull --rebase"
# Control dotfiles in git
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias dbundle='~/p/bundler/bin/bundle'
alias cdu='cd ~/ubyssey-dev/ubyssey.ca && source ../bin/activate'
alias cdus='cd ~/ubyssey-dev/ubyssey.ca && source ../bin/activate && python manage.py runserver'
alias replace_all="find .  f -exec sed -i 's/$1/$2/g; {} \;"

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
export GOPATH=$HOME/go
source ~/.tmuxinator.zsh
export DISABLE_AUTO_TITLE=true

fortune | pokemonsay
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
