#!/bin/sh
MASTER_DIR  = hugo-blog-master
# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

rm -rf $MASTER_DIR

git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

git commit -m "$msg"

git push origin main

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

cd ..

git clone git@github.com:zhangfinn/zhangfinn.github.io.git $MASTER_DIR

cd $MASTER_DIR

cp "../hugo-blog/public" ./

# Add changes to git.
git add .


git commit -m "$msg"


# Push source and build repos.
git push origin master

rm -rf $MASTER_DIR

