alias gitlog='git log --oneline --graph'
alias gitcl='git clone'
alias gitp='git push'
alias gits='git status'
alias gitf='git fetch'
function gitcc() { # git conventional commit
    echo "Select Type: "
    echo "1  => feat     Commits, that adds or remove a new feature"
    echo "2  => fix      Commits, that fixes a bug"
    echo "3  => build    Commits, that affect build components like build tool, ci pipeline, dependencies, project version, ..."
    echo "4  => chore    Miscellaneous commits e.g. modifying .gitignore"
    echo "5  => docs     Commits, that affect documentation only"
    echo "6  => refactor Commits, that rewrite/restructure your code, however does not change any API behaviour"
    echo "7  => perf     Commits are special refactor commits, that improve performance"
    echo "8  => style    Commits, that do not affect the meaning (white-space, formatting, missing semi-colons, etc)"
    echo "9  => test     Commits, that add missing tests or correcting existing tests"
    echo "10 => ops      Commits, that affect operational components like infrastructure, deployment, backup, recovery, ..."
    echo "or write custom Type"
    read commit_type
    if [[ $commit_type =~ ^[0-9]+$ ]]; then
        case $commit_type in
            1)
                commit_type="feat"
                ;;
            2)
                commit_type="fix"
                ;;
            3)
                commit_type="build"
                ;;
            4)
                commit_type="chore"
                ;;
            5)
                commit_type="docs"
                ;;
            6)
                commit_type="refactor"
                ;;
            7)
                commit_type="perf"
                ;;
            8)
                commit_type="style"
                ;;
            9)
                commit_type="test"
                ;;
            10)
                commit_type="ops"
                ;;
            *)
                commit_type="Unknown"
                ;;
        esac
    fi
    echo "commit_type: ${commit_type}"
    echo "Type Scope: press enter to leave empty"
    read Scope
    echo "Type Ticket: press enter to leave empty"
    read Ticket
    echo "Type message: press enter to leave empty"
    read message
    CommitMessage=
    if [[ $Scope == "" || $Ticket == "" ]]; then
        CommitMessage="$commit_type[$Scope$Ticket] $message"
    else
        CommitMessage="$commit_type[$Scope:$Ticket] $message"
    fi    
    echo "Commit message: $CommitMessage"
    echo "to commit y/N"
    read yes_commit
    yes_commit=$(echo "$yes_commit" | tr '[:upper:]' '[:lower:]')
    if [[ $yes_commit == "y" || $yes_commit == "yes" ]]; then
        git commit -v -m "$CommitMessage"
        echo "Commit Done"
    else
        echo "Not Commit"
    fi
}
