#!/bin/bash

# This test file will be executed against the 'install_cask' scenario, which
# installs a Homebrew cask with a Linux binary artifact ('claude-code').
#
# Casks live in Caskroom rather than Cellar and don't go through 'brew link'
# the way formulae do -- this test guards against that codepath breaking the
# whole feature install for cask packages.

set -e

source dev-container-features-test-lib

check "claude installed" bash -c "type claude"
check "claude runs" bash -c "claude --version"

reportResults
