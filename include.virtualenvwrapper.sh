if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=~/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
    export PROJECT_HOME=~/projects
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    source /usr/local/bin/virtualenvwrapper.sh
fi
