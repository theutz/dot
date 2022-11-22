if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

# pnpm
set -gx PNPM_HOME "/Users/michaelutz/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end