platform=$(uname)

alias ls='ls -aFG'
alias grep='grep --color'

if [ "$platform" = "Darwin" ]; then
    alias pdf="open -a Preview.app"
fi

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"


