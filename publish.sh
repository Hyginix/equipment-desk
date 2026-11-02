#!/bin/bash
# Publishes this folder as https://hyginix.github.io/equipment-desk/
# (public GitHub repo Hyginix/equipment-desk with GitHub Pages).
# Safe to run again: later runs just push the changes.
set -e
cd "$(dirname "$0")"
gh auth switch -u Hyginix >/dev/null
trap 'gh auth switch -u FelipeHernandezLopez >/dev/null 2>&1' EXIT
if [ ! -d .git ]; then
  git init -q -b main
  git add .
  git -c user.name="Felipe Hernandez" -c user.email="felipeherlo1293@gmail.com" commit -q -m "Home-screen front door for the Equipment Desk"
  gh repo create Hyginix/equipment-desk --public --source . --push --description "Home-screen icon and frame for the Equipment Desk app"
  gh api -X POST repos/Hyginix/equipment-desk/pages -f "source[branch]=main" -f "source[path]=/" >/dev/null
else
  git add .
  git -c user.name="Felipe Hernandez" -c user.email="felipeherlo1293@gmail.com" commit -q -m "Update" || true
  git push -q
fi
echo "✓ Published. In about a minute it opens at: https://hyginix.github.io/equipment-desk/"
