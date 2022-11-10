# Open current branch in Gitlab
glo () {
  REMOTE=$(git config --get remote.origin.url)
  URL=${REMOTE#*@}
  URL=${URL%:*}
  REPO=${REMOTE#*:}
  REPO=${REPO%.*}
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  bash_open "https://$URL/$REPO/-/tree/$BRANCH"
}

# Open current repo MRs in Gitlab
glmr () {
  REMOTE=$(git config --get remote.origin.url)
  URL=${REMOTE#*@}
  URL=${URL%:*}
  REPO=${REMOTE#*:}
  REPO=${REPO%.*}
  bash_open "https://$URL/$REPO/-/merge_requests"
}
