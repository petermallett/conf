#!/bin/bash
#
# TODO: Move to bash config to make use of platform-specific "open" cmd.

REMOTE_URL=$(git remote get-url --push origin 2> /dev/null)

if [ -z "$REMOTE_URL" ]; then
  echo "Not a git repo."
  exit 1
fi

usage() {
cat << EOF
Usage: github <options>

ex.
  github --branch

ARGUMENTS:
   --branch: Open to the current branch.
EOF
}

# Process cmd line options.
for arg in "$@"
do
    if [[ ${arg:0:1} = "-" ]]
    then
        case "$arg" in
          --help)
            usage
            exit 1
            ;;
          --branch)
            BRANCH=true;
            ;;
          * )
            echo "Unknown argument: $arg"
            echo ""
            usage
            exit 1
            ;;
        esac
    fi
done

REPO_NAME=$(echo "$REMOTE_URL" | sed 's/.*://;s/.git$//')

if [ "$BRANCH" == true ]; then
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
  open "https://github.com/$REPO_NAME/tree/$BRANCH_NAME"
else
  open "https://github.com/$REPO_NAME"
fi
