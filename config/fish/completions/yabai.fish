# Disable file completions for entire command
complete -c yabai -f

# Simiple options for first arg only
complete -c yabai -s v -l version -n __fish_is_first_arg -d "Print the version and exit."
complete -c yabai -s V -l verbose -n __fish_is_first_arg -d "Output debug information to stdout."
complete -c yabai -s m -l message -n __fish_is_first_arg -d "Send message to a running instance of yabai."
complete -c yabai -s c -l config -n __fish_is_first_arg -d "Use the specified configuration file."
complete -c yabai -l uninstall-sa -n __fish_is_first_arg -d "Uninstall the scripting-addition. Must be run as root."
complete -c yabai -l load-sa -n __fish_is_first_arg -d "Load the scripting-addition into Dock.app."

# Message Domains
set -l yabai_domains config display spac window query rule signal
complete -c yabai -n "__fish_seen_argument -s m -l message; and not __fish_seen_subcommand_from $yabai_domains" -a "$yabai_domains"

# Config Domains
set -l yabai_bool_sel on off
set -l yabai_config_settings debug_output
complete -c yabai -n "__fish_seen_argument -s m -l message; and __fish_seen_subcommand_from config" \
    -a "$yabai_config_settings"
