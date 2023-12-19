
alias gitlog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'"
alias gitcl='git clone'
alias gitph='git push'
alias gitpl='git pull'
alias gitst='git status'
alias gitfh='git fetch'
alias gitadd='git add .'
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
    echo "10 => wip      Commits, work in progress"
    echo "11 => ops      Commits, that affect operational components like infrastructure, deployment, backup, recovery, ..."
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
                commit_type="wip"
                ;;
            11)
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
function gituc() { # git conventional commit TUI
commit_type=$(whiptail --title "Conventional Commit" --menu "Commit Type" 0 0 0 \
"feat"     "Commits, that adds or remove a new feature" \
"fix"      "Commits, that fixes a bug" \
"build"    "Commits, that affect build components like build tool, ci pipeline, dependencies, project version, ..." \
"chore"    "Miscellaneous commits e.g. modifying .gitignore" \
"docs"     "Commits, that affect documentation only" \
"refactor" "Commits, that rewrite/restructure your code, however does not change any API behaviour" \
"perf"     "Commits are special refactor commits, that improve performance" \
"style"    "Commits, that do not affect the meaning (white-space, formatting, missing semi-colons, etc)" \
"test"     "Commits, that add missing tests or correcting existing tests" \
"wip"      "Commits, work in progress" \
"ops"      "Commits, that affect operational components like infrastructure, deployment, backup, recovery, ..." 3>&1 1>&2 2>&3)
if [[ $commit_type != "" ]]; then
    commit_scope=$(whiptail --title "Conventional Commit" --inputbox "Commit Scope" 0 0  3>&1 1>&2 2>&3)
    commit_ticket=$(whiptail --title "Conventional Commit" --inputbox "Commit Ticket" 0 0  3>&1 1>&2 2>&3)
    commit_description=$(whiptail --title "Conventional Commit" --inputbox "Commit Description" 0 0  3>&1 1>&2 2>&3)
    commit_body=$(whiptail --title "Conventional Commit" --inputbox "Commit Body" 0 0  3>&1 1>&2 2>&3)
    CommitMessage=
    if [[ $commit_scope == "" || $commit_ticket == "" ]]; then
        CommitMessage="$commit_type[$commit_scope$commit_ticket] $commit_description"
    else
        CommitMessage="$commit_type[$commit_scope:$commit_ticket] $commit_description"
    fi 
    if whiptail --title "Commit message " --yesno "$CommitMessage" 0 0; then
        git commit -v -m "$CommitMessage"
        echo "Commit Done"
    else
        echo "Not Commit"
    fi
fi
}
