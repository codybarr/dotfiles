# dotfiles

all my dotfiles

## MacOS Settings

Apply personal macOS preferences with the included script; Nix is not required:

```sh
./scripts/macos-settings.sh
```

The script configures screenshots, Finder, mouse/trackpad scrolling and
secondary-click behavior, a persistent Caps Lock → Escape mapping, and disables
Spotlight shortcuts and indexing. It prompts for an administrator password to
disable indexing.

## .brewfile

install homebrew - https://brew.sh/, then:

```
curl -L https://raw.githubusercontent.com/codybarr/dotfiles/master/.brewfile | brew bundle install --file=- --
```
