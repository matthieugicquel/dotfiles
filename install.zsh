#!/usr/bin/env zsh

echo "🎁 Starting the big install script"

echo "🔒 The root password will be needed"
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null & # Keep sudo alive

echo "🔐 Checking some filesystem rights"
autoload -Uz compinit && compinit
compaudit | xargs chown -R "$(whoami)"
compaudit | xargs chmod g-w

sudo chown -R $(whoami) /usr/local/share/man/man8
chmod u+w /usr/local/share/man/man8

chmod +x ./*.zsh
chmod +x ./install/*.zsh

if ! type "brew" > /dev/null; then
  echo "🚚 Installing Homebrew"
  CI=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "🚚 Updating Homebrew"
  brew update &>/dev/null
fi

# Dotfiles & config
echo "\n🔗 Setting up dotfiles"
zsh ./install/ssh-key.zsh
zsh ./install/dotfiles.zsh
zsh ./install/macOS-config.zsh
touch $HOME/.hushlogin # Disables the "Last login..." shell message

echo "🚚 Installing apps, packages and fonts with homebrew"
brew bundle --no-lock --file ./install/Brewfile
echo "🚚 Upgrading everything with homebrew"
brew upgrade
brew cask upgrade

zsh ./install/devtools-js.zsh
# zsh ./install/devtools-rust.zsh
zsh ./install/postinstall.zsh

echo "🍏 Trying to accept the Xcode License"
sudo xcodebuild -license accept

# Cleanup
echo "\n🛁 Almost done, cleaning up"
brew cleanup

echo "⌨️  Sourcing .zshrc"
source "$HOME/.zshrc"

echo "🎁 Done"
