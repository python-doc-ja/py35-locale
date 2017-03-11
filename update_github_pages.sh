#!/bin/bash
set -Ceux

cd ../../py35
git config user.email "travis-build-bot@example.com"
git config user.name "Autobuild bot on Travis-CI"
git config --local core.quotepath false
git pull origin master
# debug
git --no-pager diff -G'最終更新日時: '
git --no-pager diff --numstat | awk '$1 != 1 || $2 != 1 || $3 !~ /.html$/ { print $3 }'
# gubed
if [ $(git --no-pager diff -G'最終更新日時: ' | wc -l) -ge 1 ]; then
    git --no-pager diff --numstat | awk '$1 != 1 || $2 != 1 || $3 !~ /.html$/ { print $3 }' | xargs git add
else
    git add .
fi
git commit -a -m "update html"
git push --quiet "https://${GH_TOKEN}@github.com/python-doc-ja/py35.git" master:master
