linshortpath=$1
export PS1GITFOLD=$(pwd)
git_fold() { 
    gitfold=
    if [ -d ".git" ]; then
        gitbranch=$(git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/\1/p')
        gitcommit=$(git log -1 --pretty=format:"%h")
        gitfold="[$gitbranch:$gitcommit]"
    fi
    echo $gitfold
}
PS1='${debian_chroot:+($debian_chroot)}\[\033[03;34m\]<\W\[\033[04;01;35m\]$(git_fold)\[\033[00;34m\]>\[\033[00;37m\] '
custom_prompt() {
    if [ "$PS1GITFOLD" != "$PWD" ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[03;34m\]<\W\[\033[04;01;35m\]$(git_fold)\[\033[00;34m\]>\[\033[00;37m\] ' 
    fi    
    PS1GITFOLD=$(pwd)
}
PROMPT_COMMAND=custom_prompt
if ! command -v lsd  &> /dev/null
then
    echo "installing lsd"
    sudo snap install lsd
fi
alias ls='lsd'
alias ll='lsd -l'
alias lst='lsd --tree'
if ! command -v fdfind  &> /dev/null
then
    echo "installing fd-find"
    sudo apt install fd-find
fi
alias fdf='fdfind'
if ! command -v batcat  &> /dev/null
then
    echo "installing bat"
    sudo apt install bat
fi
alias bat='batcat'
if ! command -v autojump  &> /dev/null
then
    echo "installing autojump"
    sudo apt install autojump
fi
. /usr/share/autojump/autojump.sh
source $1/gitshort.sh
