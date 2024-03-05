linshortpath=$1
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

alias ls='lsd'
alias ll='lsd -l'
alias lst='lsd --tree'
alias fdf='fdfind'
alias bat='batcat'
. /usr/share/autojump/autojump.sh
source $1/gitshort.sh
source $1/sshshort.sh