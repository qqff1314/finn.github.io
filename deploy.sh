#!/bin/sh
# If a command fails then the deploy stops
set -e

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

git commit -m "$msg"

git push origin main

cd ..

# rm -rf hugo-blog-master
mkdire hugo-blog-master

# git clone git@github.com:zhangfinn/zhangfinn.github.io.git hugo-blog-master

cd hugo-blog-master

cp -rf "../hugo-blog/public/" ./

git init

git remote add origin	git@github.com:zhangfinn/zhangfinn.github.io.git
# Add changes to git.
git add .


git commit -m "$msg"


# Push source and build repos.
git push origin master --force

cd ../

rm -rf hugo-blog-master

