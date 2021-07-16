#!/bin/bash


echo "### FETCHING TAGS ###"
tag_fork=$(git tag -l | tail -n 1)
cd vscodium || exit
tag_upstream=$(git tag -l | tail -n 1)

if [[ "${tag_upstream}.darwin_arm64" != "${tag_fork}" ]]; then
  tag="${tag_upstream}.darwin_arm64"

  echo "### COMPILING ###"
  rm -rf VSCode*
  rm -rf vscode
  . get_repo.sh
  SHOULD_BUILD=yes CI_BUILD=no OS_NAME=osx VSCODE_ARCH=arm64 . build.sh
  cd .. || exit

  echo "### CREATING RELEASE ###"
  gh release create "${tag}" --notes "Added Darwin ARM64 binary for M1 Macs.
  Compiled on my M1 Macbook Air in just about 5 minutes 🥳"
  zip -r -X -y vscodium/VSCode-darwin-arm64/VSCodium.zip vscodium/VSCode-darwin-arm64/VSCodium.app -x "*.DS_Store"
  gh release upload "${tag}" vscodium/VSCode-darwin-arm64/VSCodium.zip

  # code below does not work, don't know why yet
  #echo "### INSTALLING ###"
  #sudo cp -r vscodium/VSCode-darwin-arm64/VSCodium.app /Applications/VSCodium.app
  #sudo xattr -r -d com.apple.quarantine /Applications/VSCodium.app
else
  echo "### ALREADY ON LATEST VERSION ###"
fi
