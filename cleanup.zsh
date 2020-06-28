#!/usr/bin/env zsh

echo "🧹 Starting the cleanup script"

echo "🧹 Xcode"
# INFO: *(N/a+x) is a glob qualifier for folders not accessed in the last x days
rm -rf $HOME/Library/Developer/Xcode/DerivedData/*(N/a+8) # Temporary build artifacts
rm -rf $HOME/Library/Developer/Xcode/Archives/*(N/a+8)
rm -rf $HOME/Library/Developer/Xcode/iOS\ DeviceSupport/*(N/a+8)
rm -rf $HOME/Library/Developer/Xcode/watchOS\ DeviceSupport/*(N/a+8)
xcrun simctl delete unavailable # Delete old simulator files
rm -rf $HOME/Library/Developer/CoreSimulator/Caches/dyld/**/*(N/a+8) # More aggressive simulator Cache removal
rm -rf $HOME/Library/Developer/CoreSimulator/Devices/*(N/a+8)
rm -rf $HOME/Library/Caches/com.apple.dt.Xcode

echo "🧹 RubyGems"
gem cleanup

echo "🧹 Yarn"
yarn cache clean

echo "🧹 Homebrew"
brew cleanup

echo "🧹 Auto cleanup done"
