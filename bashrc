
[ -z "$PS1" ] && return


export EDITOR="vim"
export GIT_EDITOR="vim"


for filename in ${DOTFILES_HOME}/include.*; do
    source $filename
done
