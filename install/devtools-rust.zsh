#!/usr/bin/env zsh

###
# Install everything that's required to work with rust
###

echo "🧰🟨 Installing Rust dev tools"
curl -sSf https://sh.rustup.rs | sh -s -- -y
# rustup completions zsh > ~/.zfunc/_rustup
