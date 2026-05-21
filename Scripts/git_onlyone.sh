#!/bin/bash

echo ">>> Execute git add ."
git add .
if [ $? -ne 0 ]; then
	echo "错误：git add 失败，请检查当前目录是否为 Git 仓库。" >&2
	exit 1
fi
echo -e "\033[34mComplete\033[0m"

echo ">>> Enter submission information\ncommit: "
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
echo -e "\033[34mComplete\033[0m"

echo ">>> Execute git push origin -u main"
git push origin -u main
if [ $? -ne 0 ]; then
	echo "Error: git push failed, please check the remote repository configuration or network connection." >&2
	exit 1
fi

echo -e "\033[34mComplete\033[0m"

