if status is-interactive
    # starship shell shell-integration
    starship init fish | source
    # navi shell-integration
    navi widget fish | source

    # zoxide shell-integration
    zoxide init --cmd cd fish | source

    # tabtab source for packages
    # uninstall by removing these lines
    # (important for pnpm)
    [ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

    if set -q KITTY_INSTALLATION_DIR
        set --global KITTY_SHELL_INTEGRATION enabled
        source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
        set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
    end
end

# gpg
set -gx GPG_TTY "(tty)"

# pnpm
set -gx PNPM_HOME /Users/michaelutz/Library/pnpm
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

set -gx LDFLAGS -L/opt/homebrew/opt/ruby/lib
set -gx CPPFLAGS -I/opt/homebrew/opt/ruby/include
