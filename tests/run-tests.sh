#!/bin/bash
set -euo pipefail

(
  cd "$(dirname "$0")"
  elm-package install -y
  elm-make Test.elm --yes --output tests.js
  node tests.js
  rm -f tests.js
)