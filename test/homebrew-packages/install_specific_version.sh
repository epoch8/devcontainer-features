#!/bin/bash

# This test file will be executed against the 'install_specific_version' scenario,
# which pins a package's version via 'package@version' syntax inside the
# 'packages' option, e.g. "node@20".

set -e

source dev-container-features-test-lib

check "node installed" bash -c "type node"
check "node version is 20" bash -c "node --version | grep 'v20\.'"

reportResults
