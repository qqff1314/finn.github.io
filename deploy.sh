#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

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

git clone git@github.com:zhangfinn/zhangfinn.github.io.git hugo-blog-master

cd hugo-blog-master

cp "../hugo-blog/public" ./

# Add changes to git.
git add .


git commit -m "$msg"


# Push source and build repos.
git push origin master

