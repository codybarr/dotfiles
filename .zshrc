HOMEBREW_BUNDLE_FILE="~/.brewfile"

# oh-my-zsh plugins
plugins=(zsh-autosuggestions asdf)

# custom aliases
alias cat="bat"
alias pretty="prettier --single-quote --use-tabs --tab-width 4 --no-semi --check \"**/*.{js,html,vue}\""
alias ls="ls -alh"
alias vim="nvim"
alias cd="z"

eval "$(zoxide init zsh)"
