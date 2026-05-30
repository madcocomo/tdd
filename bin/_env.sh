#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUNDLER_VERSION="${BUNDLER_VERSION:-2.4.22}"
USER_GEM_BIN="$(ruby -e 'print Gem.user_dir')/bin"

cd "$ROOT_DIR"
export PATH="$USER_GEM_BIN:$PATH"
export CPLUS_INCLUDE_PATH="$(xcrun --show-sdk-path)/usr/include/c++/v1${CPLUS_INCLUDE_PATH:+:$CPLUS_INCLUDE_PATH}"

bundle_cmd() {
  bundle "_${BUNDLER_VERSION}_" "$@"
}
