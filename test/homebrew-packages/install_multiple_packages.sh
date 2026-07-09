#!/bin/bash

# This test file will be executed against the 'install_multiple_packages' scenario,
# which installs two Homebrew packages ('jq' and 'wget') via a single
# space-separated 'packages' option.

set -e

source dev-container-features-test-lib

check "jq installed" bash -c "jq --version"
check "wget installed" bash -c "wget --version"

reportResults
