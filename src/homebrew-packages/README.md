
# Homebrew Packages (homebrew-packages)

Installs a list of Homebrew packages.

## Example Usage

```json
"features": {
    "ghcr.io/epoch8/devcontainer-features/homebrew-packages:1": {
        "packages": "typescript vtop wget@1.21"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| packages | Space-separated list of Homebrew packages to install. A specific version can be pinned per package with '@', e.g. "typescript wget@1.21" -- only versions currently resolvable via Homebrew's formula API are supported (e.g. "python@3.11"), not arbitrary historical versions. | string | - |
| installation_flags | Additional installation flags. These would be used as extra arguments to the brew command (`brew install <installation_flags> <package>@<version>`) | string | - |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
