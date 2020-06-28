#!/usr/bin/env zsh

brew cask uninstall android-studio
brew cask uninstall android-sdk
brew cask uninstall android-platform-tools

# From https://stackoverflow.com/questions/17625622/how-to-completely-uninstall-android-studio-on-mac
rm -Rf ~/Library/Preferences/AndroidStudio*
rm -Rf ~/Library/Preferences/com.google.android.*
rm -Rf ~/Library/Preferences/com.android.*
rm -Rf ~/Library/Application\ Support/AndroidStudio*
rm -Rf ~/Library/Logs/AndroidStudio*
rm -Rf ~/Library/Caches/AndroidStudio*
rm -Rf ~/.AndroidStudio*
rm -Rf ~/AndroidStudioProjects
rm -Rf ~/.gradle
rm -Rf ~/Library/Android*
rm -Rf ~/.emulator_console_auth_token
rm -Rf ~/.android
