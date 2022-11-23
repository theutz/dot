if status is-interactive
    starship init fish | source
    navi widget fish | source

    # tabtab source for packages
    # uninstall by removing these lines
    [ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
end

# pnpm
set -gx PNPM_HOME /Users/michaelutz/Library/pnpm
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
