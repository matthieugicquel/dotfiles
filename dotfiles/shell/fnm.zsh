#!/usr/bin/env zsh

# eval "$(fnm env --shell=zsh --use-on-cd --log-level=error)"
# Customized script to avoid logging anything

export FNM_MULTISHELL_PATH=$HOME/.fnm/current
export FNM_DIR=$HOME/.fnm/
export FNM_NODE_DIST_MIRROR=https://nodejs.org/dist
export FNM_LOGLEVEL=error

autoload -U add-zsh-hook
_fnm_autoload_hook () {
  if [[ -f .node-version && -r .node-version ]]; then
    fnm use
  elif [[ -f .nvmrc && -r .nvmrc ]]; then
    fnm use
  fi
}

add-zsh-hook chpwd _fnm_autoload_hook \
  && _fnm_autoload_hook
