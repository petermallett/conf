jira() {
  if echo "$1" | grep '[0-9]' >/dev/null; then
    if [ -z ${2+x} ]; then
      TICKETBASE=ITMKTGDES
    else
      TICKETBASE=""
    fi

    $OPEN_COMMAND "$JIRA_BASE_URL/browse/$TICKETBASE-$1" > /dev/null 2>&1
  else
    $OPEN_COMMAND "$JIRA_BASE_URL/projects/$1" > /dev/null 2>&1
  fi
}

wiki() {
  $OPEN_COMMAND "$JIRA_BASE_URL/wiki/spaces/$1" > /dev/null 2>&1
}
