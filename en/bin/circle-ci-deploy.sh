#!/bin/bash

BOOKVERSION=`cat gradle.properties | grep "^bookVersion" | cut -f2 -d=`
DBVERSION=`cat gradle.properties | grep "^docbookVersion" | cut -f2 -d=`
DBVERSION=`echo $DBVERSION | cut -f1 -db` # ignore b1, b2, ... suffixes
DBVERSION=`echo $DBVERSION | cut -f1 -dC` # ignore CR1, CR2, ... suffixes
DBVERSION=`echo $DBVERSION | cut -f2 -dV` # ignore the leading V
BUILD=`pwd`/build

mkdir /home/ubuntu/staging
cd /home/ubuntu/staging
git clone --branch=gh-pages git@github.com:ndw/defguide.git gh-pages
cd gh-pages
git rm -rf ./${DBVERSION}
mkdir -p ./${DBVERSION}
cp -Rf $BUILD/html/* ./${DBVERSION}/
git add -f .
git commit -m "CircleCI build: $CIRCLE_BUILD_URL"
git push -fq origin gh-pages

echo "Where am I?"
pwd
echo "What's here?"
ls
echo "What's the config?"
set | grep CIRCLE
echo "Home"
echo $HOME

exit 1
