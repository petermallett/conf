# Set JIRA_BASE_URL in ~/.bash_private

jira() {
  # if no argument, open to projects
  # if argument is a number, open DES issue
  # if argument has a number, but starts with a letter, open issue
  # directly

  if [[ $1 =~ [0-9] ]]; then
    if [[ $1 =~ ^[0-9] ]]; then
      TICKETBASE=ITMKTGDES-
    else
      TICKETBASE=""
    fi

    bash_open "$JIRA_BASE_URL/browse/$TICKETBASE$1"
  else
    bash_open "$JIRA_BASE_URL/projects/$1"
  fi
}

jira-des() {
  wl-copy -n "ITMKTGDES-$1"
}

#TODO: what URL should this have?
wiki() {
    bash_open "$JIRA_BASE_URL/wiki/spaces/$1"
}
