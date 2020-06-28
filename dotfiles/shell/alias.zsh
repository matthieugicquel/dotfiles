# File browsing
alias l="exa"
alias lg="exa -a | grep"
alias .="exa -a"
alias ..="cd .."
alias ql='qlmanage -p "$@" &>/dev/null' # Quicklook

function mkd() { # Create a new directory and enter it
	mkdir -p "$@" && cd "$_";
}
function cdl() { # Enter directory and display it
	cd "$@" && l;
}

# VS Code
# Usage: without args, open current folder in VS Code, with an arg, autojump to it then open in VS Code
function c () {
  if (($# != 0)); then
    j "$@"
  fi
  open -b com.microsoft.VSCode $(pwd) # Workaround to avoid multiple dock icons
}
compdef _j c

# Yarn
alias y="yarn"
alias ya="yarn add"
alias yad="yarn add --dev"
alias yj="yarn jest --watch"

# Git
alias g="git"
alias gs="git status"
alias gc="git-cz"
alias gca="git-cz -a"
alias gl="git log --color=always --pretty=format:'%C(cyan)%ad%Creset | %s' -15 --date=format:'%a %H:%M' | sed 's/\| [a-z]*: /\| /'"
alias gam="git commit --amend --no-edit"
alias gama="git commit --amend --no-edit --all"

# Jest
alias t="yarn jest --changedSince=origin/master -u"
alias tw="yarn jest --changedSince=origin/master -u --watch"

# Git functions for a "feature branch" workflow
function g_protect_master () {
  local BRANCH=$(git branch --show-current)
  if [ "$BRANCH" = "master" ]; then
    echo "☠️  Shouldn't do this this on master - press CTRL-C"
    sleep 2s
    return -1
  fi
}

function gp () {
  g_protect_master
  local BRANCH=$(git branch --show-current)
  git push -u origin $BRANCH
}
function gpn () {
  g_protect_master
  local BRANCH=$(git branch --show-current)
  git push -u origin $BRANCH --no-verify
}

function gpf {
  g_protect_master
  local BRANCH=$(git branch --show-current)
  git push -u origin $BRANCH --force
}

function gpfn {
  g_protect_master
  local BRANCH=$(git branch --show-current)
  git push -u origin $BRANCH --force --no-verify
}

function grebase () {
  g_protect_master
  local BRANCH=$(git branch --show-current)
  git fetch origin master:master
  git rebase master
}

function gwip () {
  if test -n "$(git status --porcelain)"; then
    g_protect_master
    local BRANCH=$(git branch --show-current)
    echo "👷 Creating a WIP commit"
    git add .
    git commit --no-verify -m "WIP"
  else
    echo "👷 Nothing is WIP"
  fi
}

function gunwip () {
  if test "$(git log --pretty=format:"%s" -1)" = "WIP"; then
    echo "👷 unWIPing commit"
    git reset --mixed HEAD~1
  else
    echo "👷 Nothing to unwip"
  fi
}

function gbc () {
  gwip
  echo "👷 Pulling master and creating a new branch"
  git checkout master
  git pull
  git checkout -b "$@"
}

function gbo () {
  gwip
  echo "👷 Going to the requested branch"
  git checkout "$@"
  gunwip
}
compdef _git gbo=git-branch


function gbisect () {
  git bisect start HEAD master
  git bisect run yarn jest --silent --bail --onlyChanged "$@"
  git bisect reset
}

function deploy () {
  echo "🚀 Deploying master"
  local BRANCH_BEFORE=$(git branch --show-current)
  gwip
  git checkout master
  git pull
  eval ${@:-"yarn deploy"} # Use passed command or `yarn deploy` by default
  git checkout $BRANCH_BEFORE
  gunwip
}

# React Native
alias rns="yarn react-native start"
alias rna="yarn react-native run-android"
alias rni="yarn react-native run-ios --simulator 'iPhone 8'"
alias rnsmall="yarn react-native run-ios --simulator 'iPhone SE (2nd generation)'"
alias rnbig="yarn react-native run-ios --simulator 'iPhone 11 Pro Max'"
alias rnd="yarn react-native run-ios --device 'iPhone de Matthieu'"

alias chrome="'/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary'"

alias p="tpr"
