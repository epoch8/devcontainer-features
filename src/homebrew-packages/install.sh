#!/usr/bin/env bash
set -ex

PACKAGES=${PACKAGES:-""}
INSTALLATION_FLAGS=${INSTALLATION_FLAGS:-""}

if [ -z "$PACKAGES" ]; then
	echo -e "'packages' variable is empty, skipping"
	exit 0
fi

if [ "$(id -u)" -ne 0 ]; then
	echo -e 'Script must be run as
    root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
	exit 1
fi

BREW_PREFIX="/home/linuxbrew/.linuxbrew"

ensure_curl() {
	if ! type curl >/dev/null 2>&1; then
		apt-get update -y && apt-get -y install --no-install-recommends curl ca-certificates
	fi
}

ensure_homebrew() {
	if ! type brew >/dev/null 2>&1; then
		echo "Installing Homebrew..."

		ensure_curl

		# The official installer defaults to installing formulae from Homebrew's
		# JSON API (HOMEBREW_INSTALL_FROM_API=1) instead of git-cloning the
		# homebrew-core tap, which is a multi-gigabyte, multi-million-object
		# repository. That makes this dramatically faster than manually cloning
		# brew + homebrew-core, at the cost of not being able to `brew extract`
		# formula versions that predate the current API snapshot.
		# The installer refuses to run as root unless it detects it's inside a
		# container via /.dockerenv, /run/.containerenv, or a recognized cgroup.
		# BuildKit (docker buildx) builds don't set any of those, even though
		# this genuinely is a container build step, so mark it ourselves.
		touch /.dockerenv

		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		echo "eval \"\$(${BREW_PREFIX}/bin/brew shellenv)\"" >/etc/profile.d/homebrew.sh
		chown -R "$_REMOTE_USER" "$BREW_PREFIX"

		# Solves CVE-2022-24767 mitigation in Git >2.35.2
		# For more information: https://github.blog/2022-04-12-git-security-vulnerability-announced/
		git config --system --add safe.directory "${BREW_PREFIX}/Homebrew"
	fi

	source /etc/profile.d/homebrew.sh
}

install_via_homebrew() {
	package=$1
	version=$2
	installation_flags=$3

	if [ "$version" = "latest" ] || [ -z "$version" ]; then
		package_full="$package"
	else
		package_full="${package}@${version}"
	fi

	su - "$_REMOTE_USER" <<EOF
		set -e

		# The reason for "--overwrite" flag is to not fail when a similarly
		# named binary is already linked
		brew install $installation_flags --overwrite "$package_full" --only-dependencies

		# The reason we first installing dependencies and only then the main
		# package is that some packages are big enough to reach the linux
		# open file limit. While normally this limit can be changed, the current
		# devcontainer feature building phase run unprivileged and therfore
		# cannot change the hard nofile limit from host machine during feature
		# build time.
		brew install $installation_flags --overwrite "$package_full"

		brew link --overwrite --force "$package_full"
EOF
}

ensure_homebrew

for package_spec in $PACKAGES; do
	package="${package_spec%%@*}"
	if [ "$package_spec" = "$package" ]; then
		version="latest"
	else
		version="${package_spec#*@}"
	fi

	install_via_homebrew "$package" "$version" "$INSTALLATION_FLAGS"
done
