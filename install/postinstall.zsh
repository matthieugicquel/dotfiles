#!/usr/bin/env zsh

# Use homebrew zsh as default
sudo grep -qxF '/usr/local/bin/zsh' /etc/shells || echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells

# Hammerspoon
if ! pgrep "Hammerspoon" > /dev/null; then
  open -a /Applications/Hammerspon.app
fi
defaults write org.hammerspoon.Hammerspoon MJShowMenuIconKey -int 0
defaults write org.hammerspoon.Hammerspoon MJShowDockIconKey -int 0
defaults write org.hammerspoon.Hammerspoon SUEnableAutomaticChecks -int 0

# Karabiner
if ! pgrep "karabiner" > /dev/null; then
  open -a /Applications/Karabiner-Elements.app
fi


# Quicklook plugins
defaults write org.n8gray.QLColorCode font "JetBrains Mono"

xattr -rd com.apple.quarantine ~/Library/QuickLook/*.qlgenerator
qlmanage -r >/dev/null
qlmanage -r cache >/dev/null

# Chrome Canary
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
