#!/usr/bin/env zsh

path+=/usr/local/bin

echo "⌛ $(date +'%d/%m/%y %H:%M') | Running nightly housekeeping script"

trash -f $HOME/Desktop/*(N.ah+3) # Files not accessed in the last 3 hours, "." excludes directories

cd $HOME/housekeeping
if test -n "$(git status --porcelain)"; then
  git checkout master
  git add --all
  git commit -m "Daily autosave"
  git push
fi

sleep 10 # To avoid being blacklisted by launchd for "crashing"
