# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/home/yury/.oh-my-zsh"

# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-completions node web-search sudo fzf zsh-autosuggestions zsh-syntax-highlighting) 

autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

#History setup
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell
setopt auto_cd # cd by typing directory name if it's not a command
setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate #enable approximate matches for completion

# Aliases
alias ls="colorls"
alias config="code $HOME/.zshrc"
alias now="cd $HOME/Projects/js/now"
alias reload="source $HOME/.zshrc"

# Git aliases
alias gi="git init"
alias gs="git status -sbu"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gp="git push"
alias gm="git merge"
alias ga="git add ."
alias gcm="git commit -m"
alias gpl="git pull"
alias gst="git stash"
alias gstl="git stash list"
alias glg='git log --graph --oneline --decorate --all'

# Exports

#Plugins setup
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=,bg=cyan,bold,underline"

POWERLEVEL10K_MODE='nerdfont-complete'
source ~/Software/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

sourceZsh(){
    source ~/.zshrc
    backupToDrive ~/.zshrc
    echo "New .zshrc sourced."
}

editZsh(){
    updateYadm
    vim ~/.zshrc
    source ~/.zshrc
    backupToDrive ~/.zshrc
    echo "New .zshrc sourced."
}

updateYadm() {
    yadm pull
}

backupToDrive(){
    yadm add ~/.zshrc
    yadm commit -m "updated .zshrc"
    yadm push -u origin master
    echo "New .zshrc backed up to yadm."
}