#!/usr/bin/sh
#
# Check staged changes for likely secrets before allowing commit.
if git diff --cached | grep -E "^\+.*(SECRET=|PASSWORD=|API_KEY=)"
then
    echo "Error: possible secret detected in staged changes. Commit blocked."
    exit 1
fi

# An example hook script to verify what is about to be committed.
if git rev-parse --verify HEAD >/dev/null 2>&1
then
	against=HEAD
else
	against=$(git hash-object -t tree /dev/null)
fi
allownonascii=$(git config --type=bool hooks.allownonascii)
exec 1>&2
if [ "$allownonascii" != "true" ] &&
	test $(git diff-index --cached --name-only --diff-filter=A -z $against |
	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
then
	cat <<\EOF
Error: Attempt to add a non-ASCII file name.
EOF
	exit 1
fi
exec git diff-index --check --cached $against --
