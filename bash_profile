#
# Awesome .bash_profile - Comment out things that you don't want
#

# If you create a bin folder (mkdir ~/bin), you can place your own scripts
# and binaries in it and simply use them as a normal UNIX command
PATH="/usr/local/bin:$PATH:~/bin"

# to make sublime your default editor and launch it from the terminal:
# ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
# you might need to use sudo on the above command...
export EDITOR='subl -w'

# VIRTUALENV WRAPPER ITEMS
export PIP_RESPECT_VIRTUALENV=true
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
# END OF VIRTUALENV WRAPPER ITEMS

# If you want git to suture in the current status/branch/etc,
# download https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
# and save it as ~/.git-completion.bash
# Example:
# brew install wget # if wget is not installed
# wget -o ~/.git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
#source ~/.git-completion.bash
 
# Get colorized ls output.
alias ls="ls -G"

# COLOR DEFS -- KEEP AS IS
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
NO_COLOUR="\[\033[0m\]"
CYAN="\[\033[0;36m\]"
PURPLE="\[\033[0;35m\]"

# VIRTUALENV WRAPPER ITEMS
# Determine active Python virtualenv details.
function set_virtualenv () {
    if test -z "$VIRTUAL_ENV" ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="$CYAN(`basename \"$VIRTUAL_ENV\"`)${NO_COLOUR} "
    fi
}
# END OF VIRTUALENV WRAPPER ITEMS

# GIT
function parse_git_branch () {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
 
function set_git_branch () {
  # Capture the output of the "git status" command.
 
    git_status="$(git status 2> /dev/null)"
    # Set color based on clean/staged/dirty.
    if [[ ${git_status} =~ .*"working directory clean".* ]]; then
        B_STATE="${GREEN}"
    elif [[ ${git_status} =~ .*"Changes to be committed".* ]]; then
        B_STATE="${YELLOW}"
    else
        B_STATE="${RED}"
    fi
}
# END OF GIT
 
# COMMAND PROMPT CHANGER
prompt_cmd () {
    set_virtualenv
    set_git_branch
    PS1="${PYTHON_VIRTUALENV}$NO_COLOUR\u@\h:[\W]${B_STATE}\$(parse_git_branch)$NO_COLOUR\$ "
}
 
PROMPT_COMMAND=prompt_cmd
# I advise you make a virtual env
# and fix/uncomment: (it will save you from sudo-ing stuff)
# workon MYVIRTUALENV
# END OF COMMAND PROMPT CHANGER

# local alias
alias rmr="rm *.pyc *.*~"
alias em="emacs"
