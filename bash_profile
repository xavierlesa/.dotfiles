# vim: fdm=marker foldenable sw=4 ts=4 sts=4 
#echo "loading .bash_profile..."

# fix path problems
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

# Colors {{{
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

#TERM=screen-256color
# TERM=xterm-24bit

#The command line prompt.
case "$TERM" in
    xterm) color_prompt=yes;;
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac
# }}}

# Setting for the new UTF-8 terminal support in Lion {{{
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# }}}

# Export PATH {{{
export PATH=/Library/Frameworks/Python.framework/Versions/Current/bin:$PATH
export VIM_APP_DIR=/usr/local/Cellar/macvim/8.0-137
# }}}

# mysql {{{
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export DYLD_LIBRARY_PATH=/usr/local/opt/mysql/lib:$DYLD_LIBRARY_PATH
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

# }}}

# postgres {{{
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export PGDATA=/usr/local/var/postgres9.6
alias pgstart='pg_ctl -D /usr/local/var/postgres9.6 -l logfile start'
# }}}

## para brew {{{
#echo "loading Brew completion"
#export PATH=/usr/local/sbin:$PATH
#if [ -f `brew --prefix`/etc/bash_completion ]; then
#    . `brew --prefix`/etc/bash_completion
#fi
## }}}

## Git autocomplete {{{
#echo "loading Git bash completion"
#source ~/bin/git-completion.bash
## }}}

# Compila en 64 bits {{{
export ARCHFLAGS="-arch x86_64"
# }}}

# Docker {{{
#export DOCKER_CERT_PATH=/Users/xavier/.docker/machine/machines/default
#export DOCKER_HOST=tcp://192.168.99.100:2376
#export DOCKER_TLS_VERIFY=0
#export DOCKER_MACHINE_NAME=default

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/xavier/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"

# docker-slim
#export PATH=/Users/xavier/src/docker-slim:$PATH
# }}}

## Ruby paths {{{
#echo "Loading RVM"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#PATH="$PATH:/Users/xavier/.mos/bin"
## }}}

# NVM Node Version Manager {{{
#echo "Loading NVM"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# }}}

# Virtualenv {{{
#echo "loading Virtualenv"
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper_lazy.sh
#eval "$(pipenv --completion)"
# }}}

# Custom Prompt {{{
parse_git_branch() {
    branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    branch_state=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' | grep -oE '^feature|issue|hotfix|hot-fix'`
    n=`echo $branch | wc -m`

    # https://misc.flogisoft.com/bash/tip_colors_and_formatting
    # http://shapecatcher.com/unicode/block/Arrows
    #echo -en " \033[38;5;196m⎇ \033[39m"
    #echo -en " \033[38;5;196m↥\033[39m"
    #echo -en " \033[38;5;196m⇡M$status_modified|U$status_untracked\033[39m"

    if [ ! -z "$branch" ]
    then

        # Check status of current branch
        status_untracked=`git status -s | grep '^??' | wc -l | grep -oE '\d+'`
        status_modified=`git status -s | grep '^ M' | wc -l | grep -oE '\d+'`

        # add space
        echo -n " "

        if [ $branch = "master" ]
        then
            echo -n "\[\033[48;5;98m\]\[\033[38;5;232m\][⎇ master]\[\033[00m\]"
        elif [ $branch = "develop" ]
        then
            echo -n "\[\033[48;5;82m\]\[\033[38;5;232m\][⎇ develop]\[\033[00m\]"
        elif [ $n -gt "15" ] 
        then
            echo -n "\[\033[38;5;214m\][${branch:0:3}..${branch:$n-10:$n}]\[\033[39m\]"
        else 
            echo -n "\[\033[38;5;214m\][$branch]\[\033[39m\]"
        fi

        if [ $status_untracked -gt "0" ] || [ $status_modified -gt "0" ]
        then
            #∆‹›◊› • 
            echo -n "\[\033[38;5;105m\]["

            if [ $status_modified -gt "0" ]
            then
                echo -n "ı"
            fi

            if [ $status_untracked -gt "0" ]
            then
                echo -n "±"
            fi
            
            echo -n "⇡]\[\033[00m\]"
        fi
    fi
}

aws_profile() {
    if [ ! -z "$AWS_PROFILE" ]
    then
        echo -n " \[\033[38;5;200m\][$AWS_PROFILE]\[\033[39m\]"
    fi
}

is_python3() {
    v=`python --version 2> /dev/null | grep -o -E '[0-9.]+'`
    if [ "${v:0:1}" -eq "3" ]
    then
        echo -n "³"
    fi
}

is_virtualenv() {
    if [ ! -z "$PIPENV_ACTIVE" ] && [ $PIPENV_ACTIVE = 1 ]
    then
        echo -n "\[\033[30;48;5;226m\] ENV\$(is_python3) \[\033[00m\] "
    fi
}

set_bash_prompt() {
    export PS1="$(is_virtualenv)\[\033[37m\]\u\[\033[39m\] \[\033[92m\]\W\[\033[39m\]$(parse_git_branch)$(aws_profile)\[\033[00m\] $ "
}

PROMPT_COMMAND=set_bash_prompt

#}}}

# TMUX {{{ 

tmux_alias() {
    TMUX_SESSION_NAME="$1"
    TMUX_SESSION_PATH="$2"
    if $(tmux has-session -t $TMUX_SESSION_NAME 2>/dev/null);
        then echo "Session exists"
    else
        echo "Create new session '$TMUX_SESSION_NAME'"
        touch ~/.vim/sessions/$TMUX_SESSION_NAME
        tmux new-session -d -c $TMUX_SESSION_PATH -s $TMUX_SESSION_NAME vim -S ~/.vim/sessions/$TMUX_SESSION_NAME
        tmux new-window -c $TMUX_SESSION_PATH
        tmux split-window -v -c $TMUX_SESSION_PATH
        # tmux split-window -h -c $TMUX_SESSION_PATH
        # tmux split-window -h -c $TMUX_SESSION_PATH
        tmux select-layout main-horizontal
    fi
    tmux attach-session -d -t $TMUX_SESSION_NAME
}

# }}}

# Aliases {{{
alias ll='ls -alth'
#alias mvim='~/mvim'
alias vim='nvim'
alias clearpyc='find . -name "*.pyc" -delete'
alias clearswp='find . -name "*.swp" -delete'
alias t="tmux_alias"

# Elastic 
#alias elastic='~/src/elastic/elasticsearch-5.4.0/bin/elasticsearch'

# NODEMCU
#alias nodemcu-terminal='nodemcu-uploader -b 115200 -B 115200 -p /dev/tty.SLAB_USBtoUART terminal'
#alias nodemcu-list='nodemcu-uploader -b 115200 -B 115200 -p /dev/tty.SLAB_USBtoUART file list'
#alias nodemcu-upload='nodemcu-uploader -b 115200 -B 115200 -p /dev/tty.SLAB_USBtoUART upload --verify raw'
#alias nodemcu-compile='nodemcu-uploader -b 115200 -B 115200 -p /dev/tty.SLAB_USBtoUART upload --compile --verify raw'
#alias nodemcu-rm='nodemcu-uploader -b 115200 -B 115200 -p /dev/tty.SLAB_USBtoUART file remove'
#
## VM MicroPython
#alias upystart='vboxmanage startvm micropython --type headless'
#alias upysave='vboxmanage controlvm micropython savestate'
#alias upyvm='ssh -p 2222 localhost'
#
#alias mpy-cross='~/foosible/projects/micropython/mpy-cross/mpy-cross'
#alias composer="php /usr/local/bin/composer.phar"

# VM IOT
#alias iotstart='vboxmanage startvm thinger.io --type headless'
#alias iotsave='vboxmanage controlvm thinger.io savestate'
#alias iotvm='ssh -p 22001 thingerio@localhost'
# }}}

## Serverless {{{
#echo "loading Serverless"
## tabtab source for serverless package
## uninstall by removing these lines or running `tabtab uninstall serverless`
#[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
## tabtab source for sls package
## uninstall by removing these lines or running `tabtab uninstall sls`
#[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
## tabtab source for slss package
## uninstall by removing these lines or running `tabtab uninstall slss`
#[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash
## }}}
