# TODO: adapt these to gitlab commands

bit() {
  NAME=$(basename $(git rev-parse --show-toplevel))
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  open "https://bitbucket.org/mediacurrent/"$NAME"/branch/$BRANCH"
}
bitpr() {
  NAME=$(basename $(git rev-parse --show-toplevel))
  open "https://bitbucket.org/mediacurrent/"$NAME"/pull-requests/"
}
