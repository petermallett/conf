jira() {
  if echo "$1" | grep '[0-9]' >/dev/null; then
    $OPEN_COMMAND "$JIRA_BASE_URL/browse/$1"
  else
    $OPEN_COMMAND "$JIRA_BASE_URL/projects/$1"
  fi
}

wiki() {
  $OPEN_COMMAND "$JIRA_BASE_URL/wiki/spaces/$1"
}
