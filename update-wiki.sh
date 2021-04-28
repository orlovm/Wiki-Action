#!/bin/sh

TEMP_WIKI_FOLDER="temp_wiki_$GITHUB_SHA"
WIKI_DIR=$1
GH_TOKEN=$2

if [ -z "$WIKI_DIR" ]; then
    echo "Wiki location is not specified, using default wiki/"
    WIKI_DIR='wiki/'
fi

if [ -z "$GH_TOKEN" ]; then
    echo "Token is not specified"
    exit 1
fi

#Get commit details
author=`git log -1 --format="%an"`
email=`git log -1 --format="%ae"`
message=`git log -1 --format="%s"`

#Clone wiki repo
echo "Cloning wiki repo https://github.com/$GITHUB_REPOSITORY.wiki.git"
git clone https://$GITHUB_ACTOR:$GH_TOKEN@github.com/$GITHUB_REPOSITORY.wiki.git $TEMP_WIKI_FOLDER

echo "Copying edited wiki"
cp -r $1/. $TEMP_WIKI_FOLDER

echo "Checking if wiki has changes"
cd $TEMP_WIKI_FOLDER
if git diff-index --quiet HEAD; then
  echo "Nothing changed"
  exit 0
fi

echo "Pushing changes to wiki"
git config --local user.email $email
git config --local user.name $author 
git add .
git commit -m "$message" && git push "https://$GITHUB_ACTOR:$GH_TOKEN@github.com/$GITHUB_REPOSITORY.wiki.git"
