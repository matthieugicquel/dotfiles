#!/usr/bin/env zsh

echo "🧑‍💻 Installing JS & React Native dev tools"

# Maybe some day
# echo "🧑‍💻☕ From this point, everything is automated, you can go drink a coffee"

if ! test -d "/Applications/Xcode.app"; then
  echo "🧑‍💻🍏 Xcode does not seem to be installed, and it might take some time"
  echo -n "🧑‍💻🍏 I will open the App Store when you press [ENTER]"
  read _
  open -a "App Store"
fi



echo "🧑‍💻🚚 Installing packages with homebrew"
brew bundle --no-lock --file=- <<EOF
brew 'node'
brew 'yarn'
tap 'Schniz/tap'
brew 'fnm'
cask 'flipper'
cask 'react-native-debugger'
cask 'adoptopenjdk/openjdk/adoptopenjdk8'
cask 'android-studio'
EOF

echo "🧑‍💻🔷 Setting node version"
eval "$(fnm env --multi)"
fnm install latest
fnm default latest
# $HOME/.volta/bin/volta install node yarn git-cz ios-deploy appcenter-cli


# if ! type "sdkmanager" > /dev/null; then
#   echo "🧑‍💻🤖 Opening Android Studio, please install the SDK tools and emulator with the GUI assistant"
#   echo "🧑‍💻🤖 If you know how to automate this reliably, please make a PR :)"
#   open -a "Android Studio"
# fi

# echo "🧑‍💻🤖 Accepting all the android SDK licenses"
# touch $HOME/.android/repositories.cfg
# yes | sdkmanager --licenses > /dev/null

# echo "🧑‍💻🤖 Installing android sdkmanager packages"
# # sdkmanager "platform-tools" "build-tools;27.0.3"
# # sdkmanager "sources;android-26" "platforms;android-26"
# # sdkmanager "sources;android-27" "platforms;android-27"
# # sdkmanager "extras;android;m2repository" "extras;google;m2repository"

# echo "🧑‍💻🤖 Creating a default android emulator"
# sdkmanager "system-images;android-28;google_apis;x86_64" "sources;android-28" "platforms;android-28"
# echo no | avdmanager create avd -n "default" -k "system-images;android-28;google_apis;x86_64"

if ! type "bundle" > /dev/null; then
  echo "🧑‍💻💎 Installing bundler"
  sudo chown -R "$(whoami)" /Library/Ruby/
  gem install bundler >/dev/null
fi

echo "🧑‍💻🚚 Installing VS code extensions"
while read p; do
  echo "$p"
  code --install-extension "$p" >/dev/null
done <./install/code-extensions.txt

echo "\n🧑‍💻 JS Dev tools install script done"
