# linshort
A linux terminal git and ssh helper utility

## Install
> - `git clone https://github.com/ace-dog/linshort.git`
> - `cd linshort`
> - `echo "source $(pwd)/linshort.sh $(pwd)" >> ~/.bashrc`
> - `source ~/.bashrc`

## GIT Commands
> | short     |    comamnd    |
> |:---------:|:-------------:|
> |   `gitlog` | git log --oneline --graph
> |   `gitcl`  | git clone
> |   `gitp`   | git push
> |   `gits`   | git status
> |   `gitf`   | git fetch
> |   `gitad`  | git add .
> |   `gitcc`  | git commit -m "$Type[$Scope:$Ticket] $message
> |   `gituc`  | git commit -m "$Type[$Scope:$Ticket] $message; terminal UI

## SSH Commands
> | short     |    comamnd    |
> |:---------:|:-------------:|
> |   `sshadd`  | add connection to ssh list
> |   `sshrm`   | remove connection from  ssh list
> |   `sshcnt`  | get number of connections
> |   `sshlst`  | list connections
> |   `sshcon`  | connecto to connection from list, input is source number
> |   `linssh`  | Terminal UI connection managment

