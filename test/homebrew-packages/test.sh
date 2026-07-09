#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'homebrew-packages' Feature with no options.
#
# For more information, see: https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# Thus, the value of all options will fall back to the default value in
# the Feature's 'devcontainer-feature.json'. For 'homebrew-packages', that
# means an empty 'packages' list, so the install script should skip
# installing Homebrew entirely and exit cleanly.
#
# This test can be run with the following command:
#
#    devcontainer features test \
#                   --features homebrew-packages \
#                   --remote-user root \
#                   --skip-scenarios   \
#                   --base-image mcr.microsoft.com/devcontainers/base:ubuntu \
#                   /path/to/this/repo

set -e

source dev-container-features-test-lib

check "brew not installed when packages list is empty" bash -c "! type brew"

reportResults
