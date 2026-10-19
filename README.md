# dotfiles

all my dotfiles

## Pi theme and Ghostty

- `.pi/agent/themes/cyberpunk.json`: custom cyberpunk Pi theme.
- `.config/ghostty/config`: Ghostty font, background, window, and keybinding settings.

To install from this checkout (back up existing files first):

```sh
mkdir -p ~/.pi/agent/themes ~/.config/ghostty
cp .pi/agent/themes/cyberpunk.json ~/.pi/agent/themes/
cp .config/ghostty/config ~/.config/ghostty/config
```

In Pi, select `cyberpunk` through `/settings`. Restart Ghostty to
apply all window settings. The Ghostty config uses Hack Nerd Font Mono.

## macOS bootstrap

Install a current [mise](https://mise.jdx.dev/installing-mise.html) with
`mise bootstrap` support, then install Ruby for third-party cask evaluation and
bootstrap the machine. Homebrew itself is not required:

```sh
MISE_RUBY_COMPILE=false mise install ruby@3
mise bootstrap --from https://github.com/codybarr/dotfiles.git
```

Mise clones the repository so both `mise.toml` and its companion scripts are
available. Third-party cask evaluation needs Ruby 3+, even during a dry run.
Install the prerequisite through mise (not Homebrew), then preview:

```sh
MISE_RUBY_COMPILE=false mise install ruby@3
mise bootstrap --from https://github.com/codybarr/dotfiles.git --dry-run
```

In an existing checkout, `MISE_RUBY_COMPILE=false mise install ruby` installs
the Ruby declared in `mise.toml`. This is a real Ruby install; the subsequent
bootstrap dry run does not install apps or apply settings.

AeroSpace is managed separately because this machine uses a locally built
`aerospace-dev`. Installing the stable cask alongside it causes a conflict.

For an existing local clone, run `mise trust` followed by `mise bootstrap` from
the repository directory. The individual commands below also run there.

`mise.toml` is the installation source of truth; there is no Brewfile or
`brew bundle` workflow. Ruby, Bun, Deno, Node LTS, bat, delta, Helix, htmlq, jq,
lazygit, ripgrep, and zoxide install through native mise tool backends. Mise
replaces asdf/nvm rather than installing another runtime manager.

The remaining formulas (zsh-autosuggestions and sketchybar) and app/font casks
use mise's native `brew:` and `brew-cask:` package managers. These use Homebrew
package definitions but do not run or require the Homebrew CLI. Native formula
installation on macOS requires Apple Silicon; source builds need Xcode Command
Line Tools. Ensure `/opt/homebrew/bin` is on PATH for formula executables.

Existing Homebrew installations are recognized, but casks previously installed
by Homebrew remain externally managed and are not upgraded by mise. This setup
does not uninstall Homebrew or transfer ownership of those existing casks.
Some third-party package features may not be supported by mise; an unsupported
feature error needs resolving before that package can be installed. GitHub-backed
tools and taps can require `GITHUB_TOKEN` when unauthenticated API limits are
exhausted.

Tools declared here are project-scoped: bootstrap installs them, but does not
make them your global defaults. Use `mise use -g <tool>@<version>` for tools you
want available outside this checkout, and activate mise in your shell. The
repository's `.zshrc` includes activation but is not deployed by bootstrap.

The setup applies screenshot, Finder, mouse/trackpad, Spotlight shortcut, and
persistent Caps Lock → Escape preferences declaratively. The final bootstrap
task runs `scripts/macos-settings.sh` to set the user-specific screenshot path,
disable Spotlight indexing, apply the keyboard mapping immediately, remove the
legacy LaunchAgent, and restart Finder and SystemUIServer. It prompts for an
administrator password to disable indexing on all mounted volumes. App Store
operations can require Spotlight indexing; temporarily re-enable it with
`sudo mdutil -a -i on` before future App Store installs if needed.

Preview or apply individual parts:

```sh
mise bootstrap --only packages --dry-run
mise bootstrap --only packages
mise bootstrap --only macos-defaults,task
mise bootstrap macos defaults status
```

Repeated bootstrap runs skip matching declarative state, but the final script
runs each time. Running the script directly applies only the imperative steps,
not the preferences now declared in `mise.toml`. This setup does not deploy the
repository's other dotfiles or enable services.
