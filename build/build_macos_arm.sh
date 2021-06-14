#!/bin/bash

echo "### FETCHING UPDATES ###"
git remote add upstream git@github.com:VSCodium/vscodium.git
git fetch upstream --tags
git checkout master
git merge upstream/master
git push -f origin master --tags
if [[ "$(git tag -l | tail -n 1)" =~ "darwin_arm64" ]]; then
  tag=$(git tag -l | tail -n 1)
else
  tag="$(git tag -l | tail -n 1).darwin_arm64"
fi
gh release create "${tag}" --notes "Added Darwin ARM64 binary for M1 Macs.
Compiled on my M1 Macbook Air in just about 5 minutes 🥳"
zip -r VSCode-darwin-arm64/VSCodium.zip VSCode-darwin-arm64/VSCodium.app -x "*.DS_Store"
gh release upload "${tag}" VSCode-darwin-arm64/VSCodium.zip

#echo "### COMPILING ###"
#rm -rf VSCode*
#rm -rf vscode
#. get_repo.sh
#SHOULD_BUILD=yes CI_BUILD=no OS_NAME=osx VSCODE_ARCH=arm64 . build.sh
#
#echo "### INSTALLING ###"
#cp -r VSCode-darwin-arm64/VSCodium.app /Applications/VSCodium.app

