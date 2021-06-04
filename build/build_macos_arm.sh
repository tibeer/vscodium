#!/bin/bash

echo "### FETCHING UPDATES ###"
git remote add upstream git@github.com:VSCodium/vscodium.git
git fetch upstream
git checkout master
git rebase upstream/master master
git push -f origin master

echo "### COMPILING ###"
rm -rf VSCode*
rm -rf vscode
. get_repo.sh
SHOULD_BUILD=yes CI_BUILD=no OS_NAME=osx VSCODE_ARCH=arm64 . build.sh

echo "### INSTALLING ###"
cp -r VSCode-darwin-arm64/VSCodium.app /Applications/VSCodium.app

