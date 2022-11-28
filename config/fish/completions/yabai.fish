# Disable file completions for entire command
complete -c yabai -f

# Simiple options for first arg only
complete -c yabai -s v -l version -n __fish_is_first_arg -x -d "Print the version and exit."
complete -c yabai -s V -l verbose -d "Output debug information to stdout."
complete -c yabai -s c -l config -d "Use the specified configuration file."
complete -c yabai -l uninstall-sa -x -d "Uninstall the scripting-addition. Must be run as root."
complete -c yabai -l load-sa -x -d "Load the scripting-addition into Dock.app."

set -l yabai_domain_defs '
config\t"Get or set the value of <global setting>"
display\t"Control the given display"
space\t"Control the given space"
window\t"Control the given window"
query\t"Retrieve information about displays, spaces or windows"
rule\t"Add, remove, or list rules"
signal\t"React to some event that has been processed"
'
set -l yabai_domains (echo $yabai_domain_defs | awk '{print $1}')
complete -c yabai -s m -l message -x \
    -d "Send message to a running instance of yabai." \
    -a "$yabai_domain_defs"

# Message Domains
#set -l yabai_domain_defs "config	...
#display	...
#space	...
#window	...
#query	...
#rule	...
#signal	..."
#set -l yabai_domains (echo $yabai_domain_defs | awk '{print $1}')
#complete -c yabai -s m -l message -r -d "Send message to a running instance of yabai." -a $yabai_domain_defs
#complete -c yabai -n "__fish_seen_argument -s m -l message; and not __fish_seen_subcommand_from $yabai_domains" -r -a $yabai_domain_defs
#
## Config Domains
#set -l yabai_bool_sel on off
#set -l yabai_config_settings debug_output external_bar mouse_follows_focus focus_follows_mouse
#complete -c yabai -n "__fish_seen_argument -s m -l message; and __fish_seen_subcommand_from config" \
#    -a "$yabai_config_settings"
