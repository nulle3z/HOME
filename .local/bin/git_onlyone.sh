#!/bin/bash

echo ">>> Checking git status..."
status_lines=$(git status --no-color | wc -l)
if [ $? -ne 0 ]; then
	echo "Error: git status failed, please check if the current directory is a Git repository." >&2
	exit 1
fi

if [ "$status_lines" -le 4 ]; then
	echo "Working tree is clean (status output <= 4 lines). No changes to commit. Exiting."
	exit 0
fi

echo ">>> Execute git add ."
git add .
if [ $? -ne 0 ]; then
	echo "Error: git add failed, please check if the current directory is a Git repository." >&2
	exit 1
fi
echo -e "\033[32mComplete\033[0m\n"

echo -e ">>> Enter submission information\ncommit: "
read -r commit_msg

if [ -z "$commit_msg" ]; then
	echo "Warning: The commit message is empty, the default message '$(date "+%H:%M %m.%d")' will be used" >&2
	commit_msg="$(date "+%H:%M %m.%d") update by script."
fi

echo ">>> Execute git commit -m \"$commit_msg\""
git commit -m "$commit_msg"
if [ $? -ne 0 ]; then
	echo "Error: git commit failed (there may be no changes to commit)." >&2
	exit 1
fi
echo -e "\033[32mComplete\033[0m\n"

echo ">>> Execute git push origin -u main"
git push origin -u main
if [ $? -ne 0 ]; then
	echo "Error: git push failed, please check the remote repository configuration or network connection." >&2
	exit 1
fi

echo -e "\033[32mComplete\033[0m\n"

