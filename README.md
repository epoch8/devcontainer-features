# Dev Container Features

Custom [dev container Features](https://containers.dev/implementors/features/), published to GitHub Container Registry.

## `homebrew-packages`

Installs a list of [Homebrew](https://brew.sh/) packages in one shot. A specific version can be pinned per package with `@`, e.g. `wget@1.21`.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/epoch8/devcontainer-features/homebrew-packages:1": {
            "packages": "jq wget python@3.11"
        }
    }
}
```

```bash
$ jq --version
jq-1.7.1

$ python3.11 --version
Python 3.11.15
```

See [src/homebrew-packages/README.md](src/homebrew-packages/README.md) for the full list of options.
