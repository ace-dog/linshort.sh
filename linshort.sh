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
PS1='${debian_chroot:+($debian_chroot)}\[\033[03;34m\]<\W\[\033[04;01;35m\]$(git_fold)\[\033[00;34m\]>\[\033[00;93m\] '
custom_prompt() {
    if [ "$PS1GITFOLD" != "$PWD" ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[03;34m\]<\W\[\033[04;01;35m\]$(git_fold)\[\033[00;34m\]>\[\033[00;93m\] ' 
    fi    
    PS1GITFOLD=$(pwd)
}
PROMPT_COMMAND=custom_prompt
if ! command -v lsd  &> /dev/null
then
    echo "installing lsd"
    wget https://github.com/lsd-rs/lsd/releases/download/v1.1.5/lsd-musl_1.1.5_amd64.deb --output-document=/tmp/lsd.deb
    sudo dpkg -i /tmp/lsd.deb
fi
alias ls='lsd'
alias ll='lsd -l'
alias lst='lsd --tree'
export PATH="$HOME/.cargo/bin:$PATH"
if ! command -v fd  &> /dev/null
then
    echo "installing fd-find"
    wget https://github.com/sharkdp/fd/releases/download/v10.1.0/fd-musl_10.1.0_amd64.deb --output-document=/tmp/fd.deb
    sudo dpkg -i /tmp/fd.deb
fi
if ! command -v bat  &> /dev/null
then
    echo "installing bat"
    wget https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb --output-document=/tmp/bat.deb
    sudo dpkg -i /tmp/bat.deb
fi

alias cat='bat'

# wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.tar.xz --output-document=/tmp/fonts.tar.xz
# mkdir -p ~/.fonts
# tar -xf /tmp/fonts.tar.xz -C ~/.fonts

source $1/gitshort.sh
source $1/dockershort.sh
