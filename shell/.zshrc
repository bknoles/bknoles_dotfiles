# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
autoload -U colors && colors

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' (%b)'

export TERM="xterm-256color"
export BAT_THEME="Night Owl"

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
COLOR_END=$'%f'
COLOR_USR=$'%F{blue}'
COLOR_DIR=$'%F{11}'
COLOR_GIT=$'%F{green}'
NEWLINE=$'\n'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n${COLOR_END}:${COLOR_DIR}%~ ${COLOR_GIT}${vcs_info_msg_0_}${COLOR_END}${NEWLINE}$ '

function colorgrid()
{
    iter=16
    while [ $iter -lt 52 ]
    do
        second=$[$iter+36]
        third=$[$second+36]
        four=$[$third+36]
        five=$[$four+36]
        six=$[$five+36]
        seven=$[$six+36]
        if [ $seven -gt 250 ];then seven=$[$seven-251]; fi

        echo -en "\033[38;5;$(echo $iter)m█ "
        printf "%03d" $iter
        echo -en "   \033[38;5;$(echo $second)m█ "
        printf "%03d" $second
        echo -en "   \033[38;5;$(echo $third)m█ "
        printf "%03d" $third
        echo -en "   \033[38;5;$(echo $four)m█ "
        printf "%03d" $four
        echo -en "   \033[38;5;$(echo $five)m█ "
        printf "%03d" $five
        echo -en "   \033[38;5;$(echo $six)m█ "
        printf "%03d" $six
        echo -en "   \033[38;5;$(echo $seven)m█ "
        printf "%03d" $seven

        iter=$[$iter+1]
        printf '\r\n'
    done
}

gtb() {
    local tail_amount="${2:-1}"
    git checkout $(git branch | grep "$1" | tail -$tail_amount | head -1)
}

# Initiate config for local packages
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(nodenv init -)"
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source $(dirname $(gem which colorls))/tab_complete.sh

# Aliases
alias dcr='docker-compose run'
alias dcrr='docker-compose run --rm'
alias cls='colorls'
alias rezsh='source ~/.zshrc'