#!/bin/bash

# This test file will be executed against the 'install_specific_version' scenario,
# which pins a package's version via 'package@version' syntax inside the
# 'packages' option, e.g. "python@3.11".
#
# 'python' is used here (rather than e.g. 'node') because its versioned
# formulae stay in homebrew-core HEAD, so brew can resolve them from the
# shallow tap clone. A version pin whose formula only exists in tap history
# forces brew to fall back to a full unshallow clone of homebrew-core, which
# is extremely slow and unrelated to what this test is meant to check.

set -e

source dev-container-features-test-lib

check "python3.11 installed" bash -c "type python3.11"
check "python version is 3.11" bash -c "python3.11 --version | grep 'Python 3\.11\.'"

reportResults
