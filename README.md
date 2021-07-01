# VSCodium build for Darwin ARM64

As github is missing Mac ARM runners, this repo aims to provide a native build for darwin ARM machines.
More on this can be found here: https://github.com/VSCodium/vscodium/issues/597

### Troubleshooting

If you get a message like this
```
"VSCodium.app" is damaged and can’t be opened. You should move it to the Bin.
```
this is because of Gatekeeper restrictions as the app isn't signed. You can execute the following to remove the quarantine attribute.
```
sudo xattr -r -d com.apple.quarantine /Applications/VSCodium.app
```
Thanks to @melgu ! (https://github.com/VSCodium/vscodium/issues/597#issuecomment-860065374)

