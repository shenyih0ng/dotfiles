if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ls='eza'
alias lg='lazygit'
alias cat='bat'
alias vi='nvim'
alias vim='nvim'

# git aliases

alias gs='git status'
alias gl='git log --oneline'

# vi bindings

fish_vi_key_bindings

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block
set fish_vi_force_cursor 1

# nvm

function nvm
   bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent

# zoxide

zoxide init --cmd cd fish | source

# opam

eval $(opam env)
