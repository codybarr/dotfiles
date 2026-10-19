# oh-my-zsh plugins
plugins=(zsh-autosuggestions)

# Runtime/tool management replaces asdf and nvm.
eval "$(mise activate zsh)"

# custom aliases
alias cat="bat"
alias pretty="prettier --single-quote --use-tabs --tab-width 4 --no-semi --check \"**/*.{js,html,vue}\""
alias ls="ls -alh"
alias vim="nvim"
alias cd="z"

eval "$(zoxide init zsh)"
