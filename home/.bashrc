
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias pacman='sudo pacman-color'
alias pacman-normal='sudo pacman'

#✓✔✕✖✗✘✙✚✛✜✝✞✟╭├╭╰─

prompt_command()
{
    local ret=$?

    local status=''

    [ $ret -eq 0 ] \
        && status=" \[\e[0;32m\]✔\[\e[0m\] " \
        || status=" \[\e[0;31m\]✘ \[\e[0;33m\]$ret\[\e[0m\] "

    local user='\[\e[0;34m\] \u \[\e[0m\]'
    local path='\[\e[0;36m\] \w \[\e[0m\]'
    local prompt='\[\e[1;30m\]>\[\e[0;32m\]>\[\e[1;32m\]>\[\e[m\] '

PS1="╭┤${status}├─┤${user}├─┤${path}├◑\n╰◑ ${prompt}"
#PS1="╭${status}-${info}\n╰◑ "
#PS1="${status}-${info}\n${prompt}"
}

prompt_command2 () {
    local ret=$?
    local w=`echo "${PWD/#$HOME/~}"`
    local W=`basename ${w}`

    local L=30
    [ ${#w} -gt $L ] \
        && local path="\[\033[0;36m\]${w:0:$((30 - ${#W} - 1))}\[\033[0;34m\]…\[\033[0;36m\]/${W}\[\033[0m\]" \
        || local path="\[\033[0;36m\]${w}\[\033[0m\]"

    local error=""
    [ $ret -ne 0 ] && error="\[\033[1;30m\]>\[\033[0;31m\]>\[\033[1;31m\]> \[\033[0;33m\]$ret\[\033[m\]\n"

    local prompt="\[\033[1;30m\]>\[\033[0;32m\]>\[\033[1;32m\]>\[\033[m\]"

    PS1="${error}${path} ${prompt} "
}

PROMPT_COMMAND=prompt_command2

export EDITOR="gvim"
