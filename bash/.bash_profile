[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# Show git branch in terminal output
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] \n$ "

export PATH="~/.dotfiles/scripts:~/.dotfiles/scripts/phpm:$PATH"
# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
        [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
# Increase history length
HISTSIZE=
HISTFILESIZE=

# Migrate dev and test dbs in one command on Rails projects
alias rake_db_migrate='rake db:migrate && rake db:test:prepare'

gtb() {
    local tail_amount="${2:-1}"
    git checkout $(git branch | grep "$1" | tail -$tail_amount | head -1)
}
export PATH="/usr/local/opt/node@8/bin:$PATH"

alias dcr='docker-compose run'
alias dcrr='docker-compose run --rm'

eval "$(nodenv init -)"

export PATH=$PATH:~/Library/Android/sdk/tools
