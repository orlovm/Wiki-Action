!/bin/sh

TEMP_WIKI_FOLDER="temp_wiki_$GITHUB_SHA"
GH_TOKEN=$2
#Get commit details
author=`git log -1 --format="%an"`
email=`git log -1 --format="%ae"`
message=`git log -1 --format="%s"`

#Clone wiki repo
echo "Clone wiki repo https://github.com/$GITHUB_REPOSITORY.wiki.git"
git clone https://$GITHUB_ACTOR:$GH_TOKEN@github.com/$GITHUB_REPOSITORY.wiki.git $TEMP_WIKI_FOLDER

echo "Copy edited wiki"
cp -r $1/. $TEMP_WIKI_FOLDER

echo "Check if wiki has changes"
cd $TEMP_WIKI_FOLDER
if git diff-index --quiet HEAD; then
  echo "Nothing changed"
  return
fi

echo "Setup git and push"
git config --local user.email $author
git config --local user.name $email
git add .
git commit -m "$message" && git push "https://$GITHUB_ACTOR:$GH_TOKEN@github.com/$GITHUB_REPOSITORY.wiki.git"
