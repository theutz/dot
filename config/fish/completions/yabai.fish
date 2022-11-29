# Completions for yabai

# ROOT
# Disable file completion by default
complete -f -c yabai

# ROOT > <exclusive option>
complete -x -c yabai -s v -l version \
    -d "Print the version and exit."
complete -x -c yabai -s V -l verbose \
    -d "Output debug information to stdout."
complete -x -c yabai -l uninstall-sa \
    -d "Uninstall the scripting-addition. Must be run as root."
complete -x -c yabai -l load-sa \
    -d "Load the scripting-addition into Dock.app."

# ROOT > --config
complete -F -r -c yabai -s c -l config \
    -d "Use the specified configuration file."

# ROOT > --message
complete -x -c yabai -s m -l message \
    -n __fish_is_first_arg \
    -d "Send message to a running instance of yabai."

function __yabai_echo_argspec
    argparse --min-args=1 --max-args=2 k/keys -- $argv

    set -l defs $argv[1]

    if set -lq _flag_keys
        echo -ne $defs | awk '{print $1}'
        return 0
    end

    echo -en $defs
    return 0
end

set -l message_domains '
config\tGet or set the value of <global setting>
display\tControl the given display
space\tControl the given space
window\tControl the given window
query\tRetrieve information about displays, spaces or windows
rule\tAdd, remove, or list rules
signal\tReact to some event that has been processed
'

complete -k -c yabai \
    -n "__fish_seen_argument -s m -l message" \
    -n "not __fish_seen_subcommand_from (__yabai_echo_argspec -k '$message_domains')" \
    -a "(__yabai_echo_argspec \"$message_domains\")"

# ROOT > --message > config > <setting>
set -l config_settings '
debug_output\tEnable output of debug information to stdout.
mouse_follows_focus\tWhen focusing a window, put the mouse at it\'s center.
'

complete -x -k -c yabai \
    -n "__fish_seen_argument -s m -l message" \
    -n "__fish_seen_subcommand_from config" \
    -n "not __fish_seen_subcommand_from (__yabai_echo_argspec \"$config_settings\" -k)" \
    -a "(__yabai_echo_argspec \"$config_settings\")"

set -l boolean_values '
on\tEnable option
off\tDisable option
'

complete -x -k -c yabai \
    -n "__fish_seen_argument -s m -l message" \
    -n "__fish_seen_subcommand_from config" \
    -n "__fish_prev_arg_in debug_output" \
    -a "(__yabai_echo_argspec \"$boolean_values\")"
