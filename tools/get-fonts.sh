#!/usr/bin/env bash
# Downloads the font files index.html expects into this folder. Needs Node.js + internet.
# Usage:  cd fonts && bash get-fonts.sh        (on Windows: use Git Bash or WSL)
set -e
T=$(mktemp -d)
( cd "$T" && npm init -y >/dev/null && npm i @fontsource/ibm-plex-sans @fontsource/rubik-mono-one >/dev/null )
P="$T/node_modules/@fontsource"
cp "$P"/ibm-plex-sans/files/ibm-plex-sans-{cyrillic,latin}-{400,500,600}-normal.woff2 .
cp "$P"/rubik-mono-one/files/rubik-mono-one-{cyrillic,latin}-400-normal.woff2 .
cp "$P"/ibm-plex-sans/LICENSE ./LICENSE-ibm-plex-sans.txt 2>/dev/null || true
cp "$P"/rubik-mono-one/LICENSE ./LICENSE-rubik-mono-one.txt 2>/dev/null || true
rm -rf "$T"
ls -1 *.woff2
echo "Done. Check LICENSE-*.txt against THIRD_PARTY_LICENSES.txt."
