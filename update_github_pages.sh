#!/bin/bash
set -Ceux

git config user.email "travis-build-bot@example.com"
git config user.name "Autobuild bot on Travis-CI"
git config --local core.quotepath false
git pull origin master
# debug
git --no-pager diff -G'最終更新日時: '
git --no-pager diff --numstat | awk '$1 != 1 || $2 != 1 || $3 !~ /.html$/ { print $3 }'
# gubed
if [ $(git status -s | wc -l) -eq 0 ]; then
    echo "nothing to commit"
    exit 0
elif [ $(git --no-pager diff -G'最終更新日時: ' | wc -l) -ge 1 ]; then
    git --no-pager diff --numstat | awk '$1 != 1 || $2 != 1 || $3 !~ /.html$/ { print $3 }' | xargs git add
else
    git add .
fi
git commit -m "update html"
