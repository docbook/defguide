#!/bin/bash

BOOKVERSION=`cat gradle.properties | grep "^bookVersion" | cut -f2 -d=`
DBVERSION=`cat gradle.properties | grep "^docbookVersion" | cut -f2 -d=`
DBVERSION=`echo $DBVERSION | cut -f1 -db` # ignore b1, b2, ... suffixes
DBVERSION=`echo $DBVERSION | cut -f1 -dC` # ignore CR1, CR2, ... suffixes
DBVERSION=`echo $DBVERSION | cut -f2 -dV` # ignore the leading V
BUILD=`pwd`/build
REPO="git@github.com:${CIRCLE_PROJECT_USERNAME}/defguide.git"

echo "Publishing DocBook Publishers: The Definitive Guide $BOOKVERSION for $DBVERSION"
echo "Publishing to gh-pages in $REPO"

mkdir $HOME/staging
cd $HOME/staging

git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_USER
git clone --quiet --branch=gh-pages "$REPO" gh-pages

cd gh-pages

# Set this in the CircleCI "Settings/Environment Variables" section
if [ "$GITHUB_CNAME" != "" ]; then
    echo $GITHUB_CNAME > CNAME
fi;

mkdir -p ./tdg/publishers/${DBVERSION}
rsync -var --delete $BUILD/html/ ./tdg/publishers/${DBVERSION}/

git add --all .
git commit -m "CircleCI build: $CIRCLE_BUILD_URL"
git push -fq origin gh-pages
