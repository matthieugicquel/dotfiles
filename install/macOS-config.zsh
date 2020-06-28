#!/usr/bin/env zsh

# Prevent overriding the settings we're about to change
osascript -e 'tell application "System Preferences" to quit'

echo "🔧 Setting computer network names"
sudo scutil --set LocalHostName macbook-matthieu
sudo scutil --set HostName macbook-matthieu
sudo scutil --set ComputerName MacBook Matthieu

echo "🔧 Configuring finder"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Display library
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library &>/dev/null


echo "🔧 Configuring keyboard & trackpad"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
# Allow tab in dialogs
sudo defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# Enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "🔧 Configuring Safari"
defaults write com.apple.safari IncludeDevelopMenu -int 1
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
defaults write com.apple.safari ShowOverlayStatusBar -int 1
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

echo "🔧 Configuring other things"
# Disable quarantine alert
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Don't open a photo window when plugging a phone
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES
# Disable auto-completion when pressing esc
defaults write -g NSUseSpellCheckerForCompletions -bool false
# Start silent
sudo nvram SystemAudioVolume="%00"
# Don't automatically rearrange spaces
defaults write com.apple.dock mru-spaces -bool false
# Set sidebar icon size to small - applies to other apps as well
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
# Expand save dialog
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# Disable the crash reporter
#defaults write com.apple.CrashReporter DialogType -string "none"
# Disable autocorrect
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Sceeenshots
defaults write com.apple.screencapture type -string “png”
defaults write com.apple.screencapture location -string “$HOME/Desktop”
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "🔧 Building Dock"
defaults write com.apple.dock tilesize -int 48
dockutil --remove all --no-restart
if [ -d "/Applications/Safari Technology Preview.app" ]; then
  dockutil --add "/Applications/Safari Technology Preview.app" --no-restart
else
  dockutil --add "/Applications/Safari.app" --no-restart
fi
dockutil --add "/Applications/Visual Studio Code.app" --no-restart
dockutil --add "/System/Applications/Utilities/Terminal.app" --no-restart
dockutil --add "/Applications/Fork.app" --no-restart
dockutil --add "/Applications/Discord.app" --no-restart
dockutil --add "/Applications/Notion.app" --no-restart
dockutil --add "/Applications/Hey.app" --no-restart
dockutil --add "$HOME/Downloads/" --display stack --no-restart
dockutil --add "$HOME/Desktop/" --display stack --no-restart

echo "💣 Restarting Finder & Dock"
killall cfsprefsd &>/dev/null
killall SystemUIServer &>/dev/null
killall Dock
killall Finder
