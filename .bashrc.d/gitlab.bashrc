# Set GITLAB_BASE_URL in ~/.bash_private

# Open current branch in Gitlab
glo () {
  REMOTE=$(git config --get remote.origin.url)
  REPO=${REMOTE#*:}
  REPO=${REPO%.*}
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  bash_open "$GITLAB_BASE_URL/"$REPO"/-/tree/"$BRANCH""
}

# Open current repo MRs in Gitlab
glmr () {
  REMOTE=$(git config --get remote.origin.url)
  REPO=${REMOTE#*:}
  REPO=${REPO%.*}
  bash_open "$GITLAB_BASE_URL/"$REPO"/-/merge_requests"
}
