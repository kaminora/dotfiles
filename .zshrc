## prompt
PROMPT="%{${fg[blue]}%}$%{${reset_color}%} "
export PROMPT="%B[%{$fg[default]%}%/]%{$fg[cyan]%} $%b"


## vcs_info

autoload -Uz vcs_info
#PROMPT変数内で変数参照する
setopt prompt_subst
#vcsの表示
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}!'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}+'
zstyle ':vcs_info:*' formats '%F{green}%c%u[%b]%f'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
# プロンプト表示直前にvcs_info呼び出し
precmd() { vcs_info }
# プロンプト表示
PROMPT='${vcs_info_msg_0_}'$PROMPT

## complement

autoload -U compinit; compinit -u
setopt auto_list
setopt auto_menu
setopt list_packed
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


## color

autoload -Uz colors
colors


## history

setopt hist_ignore_dups
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000


## ディレクトリ移動

setopt auto_cd
function chpwd() { ls }


## alias

alias cdh='cd ~'
alias la='ls -a'
alias ll='ls -l'
alias rg='rails g'
alias rgc='rails g controller'
alias ds='bundle exec cap staging deploy'
alias rake='bundle exec rake'
alias rr='bundle exec rake routes'
alias rdm='bundle exec rake db:migrate'
alias rdc='bundle exec rake db:create'
alias rds='bundle exec rake db:seed'
alias rdr='bundle exec rake db:rollback'
alias be='bundle exec'
alias os='open -a sublime\ text'
alias ls='ls -G'
alias rs='rails s'
alias rs4='rails s -p 4000'
alias rs5='rails s -p 5000'
alias rc='rails c'
alias v='mvim .'
alias vv='mvim ~/.vimrc'
alias vz='mvim ~/.zshrc'
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gc1='git commit --allow-empty -m "create PR"'
alias gb='git branch'
alias gch='git checkout'
alias gs='git status'
alias gr='git reset'
alias gp='git pull'
alias hc='hub clone'
alias rm='gmv -f --backup=numbered --target-directory ~/.Trash'
alias cleartrash='\rm ~/.Trash/*'
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

## less
export LESS="-N"

## tmux
alias t='tmux'
alias tname='tmux new -s'

function op() {
  if [ -z "$1" ]; then
    open .
  else
    open "$@"
  fi
}


## config

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"


## rubyコマンドパス設定

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"


## cdr の設定

zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true


########################################
# peco
########################################

alias -g P='| peco'
if [ -x "`which peco`" ]; then
    alias ll='ls -la | peco'
    alias tp='top | peco'
    alias pp='ps aux | peco'

    function peco-select-history() {
        local tac
        if which tac > /dev/null; then
            tac="tac"
        else
            tac="tail -r"
        fi
        BUFFER=$(history -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle clear-screen
    }

    autoload -Uz is-at-least
    if is-at-least 4.3.11
    then
        autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
        add-zsh-hook chpwd chpwd_recent_dirs
        zstyle ':chpwd:*' recent-dirs-max 5000
        zstyle ':chpwd:*' recent-dirs-default yes
        zstyle ':completion:*' recent-dirs-insert both
    fi
    zle -N peco-select-history
    bindkey '^r' peco-select-history

    function peco-cdr () {
        local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
        if [ -n "$selected_dir" ]; then
            BUFFER="cd ${selected_dir}"
            zle accept-line
        fi
        zle clear-screen
    }
    zle -N peco-cdr
    bindkey '^f' peco-cdr

    function peco-kill-process () {
        ps -ef | peco | awk '{ print $2 }' | xargs kill
        zle clear-screen
    }
    zle -N peco-kill-process
    bindkey '^xk' peco-kill-process

fi
