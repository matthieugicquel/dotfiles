#!/usr/bin/env zsh

# This is a script equivalent of:
# https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

source dotfiles/env.zsh

if test ! -f "$HOME/.ssh/id_rsa"; then
  echo "🔏 No existing id_rsa, creating one"
  ssh-keygen -t rsa -b 4096 -C "matthieug@hey.com" -f "$HOME/.ssh/id_rsa"
  if ! pgrep "ssh-agent" > /dev/null; then
    eval "$(ssh-agent -s)" > /dev/null
  fi
  ssh-add -K ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
  echo "🔏Public key copied to clipboard, opening Github"
  open "https://github.com/settings/ssh/new"
else
  echo "🔏SSH seems to be already set-up"
fi
