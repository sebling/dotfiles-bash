if [ $(uname) = "Darwin" ]; then
    export CLICOLOR=1
    export LSCOLORS="exfxcxdxbxegedabagacad"
fi


# if not running under bash, then bail
[ $(ps -p $$ | tail -1 | awk '{print $NF}' | sed 's/^-//') != "bash" ] && return
echo "bashing"

echo

echo -e "${Blue}Go${Color_Off} ${Yellow}Racers!${Color_Off}"


# define ansi color codes
#
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White


function psc() {
    echo -n "\[$1\]"
}


function lastcode_prompt() {
    code=$?
    if [ $code != 0 ]; then
        echo -n "-`psc ${BRed}`exit`psc ${Color_Off}` `psc ${BCyan}`$code`psc ${Color_Off}`- "
    fi
}

function user_prompt() {
    if [ $(id -u) == '0' ]; then
        echo -n "`psc ${BIRed}`"
    else
        echo -n "`psc ${Purple}`"
    fi
    echo -n "\u`psc ${Color_Off}`"
}


function host_prompt() {
    echo -n "`psc ${Yellow}`\h`psc ${Color_Off}`"
}


function path_prompt() {
    echo -n "`psc ${Green}`\w`psc ${Color_Off}`"
}


function virtualenv_prompt() {
    if ! test -z "$VIRTUAL_ENV"; then
        local env_name=$(basename ${VIRTUAL_ENV})
        echo -n $" `psc ${White}`workon `psc ${BRed}`"
        echo -n $env_name
        echo -n $"`psc ${Color_Off}` "
    fi
}


function is_git_repo() {
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
    if [ ! -z "$branch" ]; then
        echo -n " git `psc ${BCyan}`$branch`psc ${Color_Off}` "
    fi
}


function is_hg_repo() {
    branch=$(hg branch 2> /dev/null)
    if [ ! -z "$branch" ]; then
        echo -n " hg `psc ${BCyan}`($branch)`psc ${Color_Off}` "
    fi
}


function repo_prompt() {
    is_git_repo
    is_hg_repo
}


function prompt_cmd() {
    export BASE_PROMPT="\033]0;\007\n`lastcode_prompt``user_prompt` at `host_prompt` in `path_prompt``virtualenv_prompt``repo_prompt`"
    if [ $(id -u) == '0' ]; then
        export PS1="\[\033[G\]${BASE_PROMPT}
# "
    else
        export PS1="\[\033[G\]${BASE_PROMPT}
$ "
    fi
}


PROMPT_COMMAND=prompt_cmd
