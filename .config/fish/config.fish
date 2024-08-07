[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
set -g fish_user_paths "/home/mhlz/.local/bin" "/home/mhlz/go/bin" "/usr/local/sbin" "/opt/anaconda/bin" "/home/mhlz/.cargo/bin" $fish_user_paths
test -e /opt/homebrew/bin; and fish_add_path /opt/homebrew/bin/

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

set -x GPG_TTY (tty)
set -gx EDITOR nvim

set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

set -gx LANG en_US.UTF-8
set -gx LC_NUMERIC de_DE.UTF-8
set -gx LC_TIME de_DE.UTF-8
set -gx LC_MONETARY de_DE.UTF-8


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.fish

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mhlz/homefully/sandbox/google-cloud-sdk/path.fish.inc' ]; . '/Users/mhlz/homefully/sandbox/google-cloud-sdk/path.fish.inc'; end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /opt/anaconda/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

starship init fish | source

# pnpm
set -gx PNPM_HOME "/home/mhlz/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
