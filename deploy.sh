#!/bin/sh
# If a command fails then the deploy stops
set -e

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

rm -rf hugo-blog-master

git clone git@github.com:zhangfinn/zhangfinn.github.io.git hugo-blog-master

cd hugo-blog-master

cp -rf "../hugo-blog/public/" ./

# Add changes to git.
git add .


git commit -m "$msg"


# Push source and build repos.
git push origin master

cd ../

rm -rf hugo-blog-master

