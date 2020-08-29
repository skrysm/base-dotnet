#!/bin/sh -e

# Delete all ignored files
git clean -f -X .

# Delete all untracked files and directories.
# NOTE: Since directories are never tracked by git, this command
#   will effectively delete all empty directories.
# NOTE 2: Tracked files with unstaged changes will not be touched.
git clean -f -d .
