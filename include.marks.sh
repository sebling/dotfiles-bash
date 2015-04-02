platform=$(uname)

# stole these somewhere, but they are handy,
# especially with my absurd need for subdirs
##-- Marks --##
export MARKPATH=$HOME/.marks
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

function unmark { 
    rm -i "$MARKPATH/$1"
}

if [ "$platform" = "Darwin" ]; then
    function marks {
        \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
    }
else
    function marks {
        ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' &&
            echo
    }
fi

_completemarks() {
    local curw=${COMP_WORDS[COMP_CWORD]}
    local wordlist=$(for filename in `find $MARKPATH -type l`; do echo `basename $filename`; done)
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
}

complete -F _completemarks jump unmark
##-- Marks --##
