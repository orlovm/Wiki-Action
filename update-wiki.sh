#!/bin/sh

#Get commit details
author=`git log -1 --format="%an"`
email=`git log -1 --format="%ae"`
message=`git log -1 --format="%s"`

#Copy edited wiki 
cp -r $1/. wiki-repo

#Check if wiki has changes
cd wiki-repo
if git diff-index --quiet HEAD; then
  echo "Nothing changed"
  return
fi

#Setup git and push
git config --local user.email $author
git config --local user.name $email
git add .
git commit -m "$message" && git push
