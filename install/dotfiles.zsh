#!/usr/bin/env zsh

DOTFILES_DIR=${0:a:h:h}/dotfiles
DOTFILES_SAVE_DIR=$DOTFILES_DIR-old-$(date +%s)

# args: source file, relative to DOTFILES_DIR/, target path, relative to HOME/
function dotfile () {
  local SOURCE_PATH="$DOTFILES_DIR/$1" # source file path, inside $DOTFILES_DIR
  local TARGET_PATH="$HOME/$2" # target path relative to $HOME

  local SAVE_PATH="$DOTFILES_SAVE_DIR/$1"

  if [ "$SOURCE_PATH" = "$(readlink $TARGET_PATH)" ]; then
    echo "⚪️ Link already exists: $1 => $TARGET_PATH"
    return 0;
  fi;

  if [ -f "$TARGET_PATH" ] && [ ! -L "$TARGET_PATH" ]; then
    echo "🔶 A real file exists at ~/$2, saving it in $DOTFILES_SAVE_DIR"
    mkdir -p ${SAVE_PATH:h} &&
    cp $TARGET_PATH $SAVE_PATH
  fi

  echo "🔗 Linking dotfile $1 => $TARGET_PATH"
  mkdir -p ${TARGET_PATH:h} &&
  ln -fs $SOURCE_PATH $TARGET_PATH
}

dotfile shell/zshrc                .zshrc
dotfile git/gitconfig              .gitconfig
dotfile shell/starship.toml        .config/starship.toml
dotfile shell/alias.zsh            .config/alias.zsh
dotfile karabiner/karabiner.json   .config/karabiner/karabiner.json
dotfile shell/fnm.zsh              .config/fnm.zsh
dotfile hammerspoon/init.lua       .hammerspoon/init.lua
dotfile vscode/settings.json        Library/Application\ Support/Code/User/settings.json
dotfile vscode/keybindings.json     Library/Application\ Support/Code/User/keybindings.json
dotfile ssh/config                 .ssh/config
dotfile keyboard/fr-dev.keylayout   Library/Keyboard\ Layouts/fr-dev.keylayout

# args: <NAME>, with existing files cron/<NAME>.plist & cron/<NAME>.zsh
function launchfile () {
  local NAME="$1"

  local SCRIPT="$DOTFILES_DIR/cron/$1.zsh"
  chmod +x $SCRIPT

  local SOURCE_PLIST="cron/$1.plist"
  local TARGET_PLIST="Library/LaunchAgents/mg.housekeeping.$NAME.plist"
  dotfile $SOURCE_PLIST $TARGET_PLIST

  launchctl unload "$HOME/$TARGET_PLIST"
  launchctl load "$HOME/$TARGET_PLIST"
}

launchfile nightly
launchfile weekly
