#!/bin/bash

BOOKVERSION=`cat gradle.properties | grep "^bookVersion" | cut -f2 -d=`
DBVERSION=`cat gradle.properties | grep "^docbookVersion" | cut -f2 -d=`
DBVERSION=`echo $DBVERSION | cut -f1 -db` # ignore b1, b2, ... suffixes
DBVERSION=`echo $DBVERSION | cut -f1 -dC` # ignore CR1, CR2, ... suffixes
BUILD=`pwd`/build

mkdir /home/ubuntu/staging
cd /home/ubuntu/staging
git clone --branch=gh-pages git@github.com:ndw/defguide.git gh-pages
ls

echo "Where am I?"
pwd
echo "What's here?"
ls
echo "What's the config?"
set | grep CIRCLE
echo "Home"
echo $HOME

exit 1
