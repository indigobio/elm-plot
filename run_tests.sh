#!/bin/bash
set -euo pipefail

(
  cd "$(dirname "$0")"
  if ! hash elm-test 2> /dev/null; then
    sudo npm install -g elm-test
  fi
  elm-test
)