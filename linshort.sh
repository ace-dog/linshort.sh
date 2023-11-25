linshortpath=$1
git_fold() {
    gitfold=
    if [ -d ".git" ]; then
        gitbranch=$(git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/\1/p')
        gitcommit=$(git log -1 --pretty=format:"%h")
        gitfold="<$gitbranch:$gitcommit>"
    fi
    echo $gitfold
}
PS1='\[\033[03;04;34m\]\W\[\033[00;02;35m\]$(git_fold)\[\033[00;37m\] '
source $1/gitshort.sh
source $1/sshshort.sh