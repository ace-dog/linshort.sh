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
PS1='${debian_chroot:+($debian_chroot)}\033[1;3;34;46m\W\033[04;01;35;105m$(git_fold)\033[00;91;49m>\033[00;37;49m'
source $1/gitshort.sh
source $1/sshshort.sh