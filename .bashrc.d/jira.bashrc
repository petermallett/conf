# Set JIRA_BASE_URL in ~/.bash_private

jira() {
    # if no argument, open to projects
    # if argument is a number, open PLATSVCS issue
    # if argument has a number, but starts with DES, open DES issue
    # if argument has a number, but starts with a letter, open issue
    # directly

    if [[ $1 =~ [0-9] ]]; then
        NUM=$1
        if [[ $1 =~ ^[0-9] ]]; then
            TICKETBASE="PLATSVCS-"
        else
            if [[ $1 == *"DES"* ]]; then
                NUM=$(echo "$1" | grep -oE '[0-9]+([.][0-9]+)?')
                TICKETBASE="ITMKTGDES-"
            else
                TICKETBASE=""
            fi
        fi
        bash_open "$JIRA_BASE_URL/browse/$TICKETBASE$NUM"
    else
        bash_open "$JIRA_BASE_URL/projects/$1"
    fi
}

jira-des() {
  wl-copy -n "ITMKTGDES-$1"
}

# Set WIKI_BASE_URL in ~/.bash_private
wiki() {
    bash_open "$WIKI_BASE_URL/docs/projects/$1"
}
