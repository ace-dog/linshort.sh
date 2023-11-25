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
> |   `gilog` | git log --oneline --graph
> |   `gicl`  | git clone`
> |   `gip`   | git push`
> |   `gis`   | git status`
> |   `gif`   | git fetch`
> |   `gicc`  | git commit -m "$Type[$Scope:$Ticket] $message

## SSH Commands
> | short     |    comamnd    |
> |:---------:|:-------------:|
> |   `sshadd`  | add connection to ssh list
> |   `sshrm`   | remove connection from  ssh list
> |   `sshcnt`  | get number of connections
> |   `sshlst`  | list connections
> |   `sshcon`  | connecto to connection from list, input is source number

