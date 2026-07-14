
# Homebrew Packages (homebrew-packages)

Installs a list of Homebrew packages.

## Example Usage

```json
"features": {
    "ghcr.io/epoch8/devcontainer-features/homebrew-packages:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| packages | Space-separated list of Homebrew packages to install. Both formulae and casks with Linux binary artifacts (e.g. "claude-code") are supported. A specific version can be pinned per package with '@', e.g. "typescript wget@1.21" -- only versions currently resolvable via Homebrew's API are supported (e.g. "python@3.11"), not arbitrary historical versions. | string | - |
| installation_flags | Additional installation flags. These would be used as extra arguments to the brew command (`brew install <installation_flags> <package>@<version>`) | string | - |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/epoch8/devcontainer-features/blob/main/src/homebrew-packages/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
