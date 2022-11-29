# Completions for yabai

# ROOT
# Disable file completion by default
complete -f -c yabai

# ROOT > exclusive
complete -x -c yabai -s v -l version \
    -d "Print the version and exit."
complete -x -c yabai -s V -l verbose \
    -d "Output debug information to stdout."
complete -x -c yabai -l uninstall-sa \
    -d "Uninstall the scripting-addition. Must be run as root."
complete -x -c yabai -l load-sa \
    -d "Load the scripting-addition into Dock.app."
complete -F -r -c yabai -s c -l config \
    -d "Use the specified configuration file."

#set -l yabai_domain_defs '
#config\t"Get or set the value of <global setting>"
#display\t"Control the given display"
#space\t"Control the given space"
#window\t"Control the given window"
#query\t"Retrieve information about displays, spaces or windows"
#rule\t"Add, remove, or list rules"
#signal\t"React to some event that has been processed"
#'
#set -l yabai_domains (echo $yabai_domain_defs | awk '{print $1}')
#complete -c yabai -s m -l message -x \
#    -n "__fish_is_nth_token 1" \
#    -d "Send message to a running instance of yabai." \
#    -a "$yabai_domain_defs"
#
#set -l yabai_config_settings '
#  debug_output\t"Enable output of debug information to stdout."
#  mouse_follows_focus\t"When focusing a window, put the mouse at it\'s center."
#'
#set -l yabai_settings (echo $yabai_config_settings | awk '{print $1}')
#complete -c yabai -l space \
#    -n "__fish_seen_argument -s m -l message" \
#    -n "__fish_seen_subcommand_from config" \
#    -n "not __fish_seen_subcommand_from $yabai_settings" \
#    -d "Get or set the value of <space setting>."
#complete -c yabai -n "__fish_seen_argument -s m -l message" \
#    -n "__fish_seen_subcommand_from config" \
#    -n "not __fish_seen_subcommand_from $yabai_settings" \
#    -a $yabai_config_settings
#
#complete -c yabai \
#    -n "__fish_seen_subcommand_from config" \
#    -n "__fish_seen_subcommand_from debug_output" \
#    -a "$yabai_bool_sel"
#
## Message Domains
##set -l yabai_domain_defs "config	...
##display	...
##space	...
##window	...
##query	...
##rule	...
##signal	..."
##set -l yabai_domains (echo $yabai_domain_defs | awk '{print $1}')
##complete -c yabai -s m -l message -r -d "Send message to a running instance of yabai." -a $yabai_domain_defs
##complete -c yabai -n "__fish_seen_argument -s m -l message; and not __fish_seen_subcommand_from $yabai_domains" -r -a $yabai_domain_defs
##
### Config Domains
##set -l yabai_bool_sel on off
##set -l yabai_config_settings debug_output external_bar mouse_follows_focus focus_follows_mouse
##complete -c yabai -n "__fish_seen_argument -s m -l message; and __fish_seen_subcommand_from config" \
##    -a "$yabai_config_settings"
