#!/bin/sh
#

# A git pre-commit hook which removes trailing whitespace and convert tabs to
# two spaces. Bypass it with the --no-verify option to git-commit
#

if git-rev-parse --verify HEAD >/dev/null 2>&1 ; then
  against=HEAD
else
  # Initial commit: diff against an empty tree object
  against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi
# Find files with trailing whitespace
for FILE in `exec git diff-index --check --cached $against -- | sed '/^[+-]/d' | (sed -r 's/:[0-9]+:.*//' > /dev/null 2>&1 || sed -E 's/:[0-9]+:.*//') | uniq` ; do
  if [ $FILE="strip_whitespace.sh" ];
  then
    sed -i '' -E 's/[[:space:]]*$//' "$FILE" "$FILE"
    sed -i '' -E 's/	/  /g' "$FILE" "$FILE"
    git add "$FILE"
  fi
done

# Now we can commit
exit
