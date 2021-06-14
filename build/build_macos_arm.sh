#!/bin/bash

echo "### FETCHING UPDATES ###"
git remote add upstream git@github.com:VSCodium/vscodium.git
git fetch upstream --all --tags
git checkout master
git rebase upstream/master master
git tag -a $(git tag -l | tail -n 1).darwin_arm64 -m "Added Darwin ARM64 binary for M1 Macs." -m "Compiled on my M1 Macbook Air in just about 5 minutes 🥳"
git push -f origin master --tags

echo "### COMPILING ###"
rm -rf VSCode*
rm -rf vscode
. get_repo.sh
SHOULD_BUILD=yes CI_BUILD=no OS_NAME=osx VSCODE_ARCH=arm64 . build.sh

echo "### INSTALLING ###"
cp -r VSCode-darwin-arm64/VSCodium.app /Applications/VSCodium.app

