export ZSH="/home/michals/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

# Add snap to the path variable
export PATH=$PATH:/snap/bin

# Set vim as a default editor
export EDITOR=nvim

# Chromium binary
export CHROME_BIN=/usr/bin/chromium

# Add Scripts dir to the PATH variable
export PATH=$PATH:/home/michals/Desktop/Scripts

export PATH=$PATH:/home/michals/.local/bin

# Disable loading ranger's default config
export RANGER_LOAD_DEFAULT_RC="false"

# Add npm global to the path (avoid permission errors)
export PATH=~/.npm-global/bin:$PATH

# Make homeshick command visible to the system
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# Make nvm visible to the system
source /usr/share/nvm/init-nvm.sh

# Composer global
export PATH=$PATH:/home/michals/.config/composer/vendor/bin

# Enable vi mode in zsh
bindkey -v

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Add Arcanist to the path variable
export PATH="$PATH:/home/michals/.local/arcanist/arcanist/bin/"

# Add yarn gloabls to the path
export PATH="$PATH:`yarn global bin`"

# Make things visible for the system
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gcam='git commit -am'
alias gp='git push'
alias gpom='git push origin master'
alias gpl='git pull'
alias gplom='git pull origin master'
alias gcout='git checkout'
alias gnewb='git checkout -b'
alias ginit='git init'
alias greset='git reset --hard'
alias arcp='arc patch'
alias arcd='arc diff'
alias nmclean='rm -rf node_modules && npm ci'
alias gstash='git stash'
alias gclean='git clean -df'
alias gbranch='git branch'
alias catt='cat xargs | less'
alias files='xdg-open .'
alias arcdu='arc diff --update'
alias zat='zathura --mode fullscreen'
alias vim='nvim'
alias hsh='homeshick'
alias myfind='find ./** -type f -name'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias vimc='vim ~/.vimrc'
alias zshc='vim ~/.zshrc'
alias i3c='vim ~/.config/i3/config'
alias pbc='vim ~/.config/polybar/config'
alias v='vim'

# Makes ranger change dir to the one we are in when exiting
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi  
    rm -f -- "$tempfile"
}


# Open ranger on ctrl+o (ranger-cd means that it'll change dir when closed)
bindkey -s '^O' 'ranger-cd\n'

bindkey -s '^P' 'my_fzf\n'

ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

my_fzf() {
	cd $(find -L /home/michals \( -path '*/\.*' -o -path '/**/node_modules' -o -fstype 'dev' -o -fstype 'proc' \) -prune -o -type d -print 2> /dev/null | sed 1d | cut -b1- | fzf --preview 'bat --style=numbers --color=always {} | head -500' +m)
}

