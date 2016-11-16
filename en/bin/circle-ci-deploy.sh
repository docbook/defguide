#!/bin/bash

if [ "$CIRCLE_TAG" = "" ]; then
    echo "Only tagged builds are deployed to gh-pages"
    exit 0
fi

BOOKVERSION=`cat gradle.properties | grep "^bookVersion" | cut -f2 -d=`
DBVERSION=`cat gradle.properties | grep "^docbookVersion" | cut -f2 -d=`
DBVERSION=`echo $DBVERSION | cut -f1 -db` # ignore b1, b2, ... suffixes
DBVERSION=`echo $DBVERSION | cut -f1 -dC` # ignore CR1, CR2, ... suffixes
DBVERSION=`echo $DBVERSION | cut -f2 -dV` # ignore the leading V
BUILD=`pwd`/build

mkdir $HOME/staging
cd $HOME/staging
git config --global user.email "ndw@nwalsh.com"
git config --global user.name "Norman Walsh"
git clone --branch=gh-pages git@github.com:ndw/defguide.git gh-pages
cd gh-pages
if [ -d ./tdg/{$DBVERSION} ]; then
    git rm -rf ./tdg/${DBVERSION}
fi
mkdir -p ./tdg/${DBVERSION}
cp -Rf $BUILD/html/* ./tdg/${DBVERSION}/
git add -f .
git commit -m "CircleCI build: $CIRCLE_BUILD_URL"
git push -fq origin gh-pages

