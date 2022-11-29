# Completions for yabai

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

# `yabai`
complete -f -c yabai # Disable file completion by default

# `yabai -v`
# `yabai --version`
complete -x -c yabai -s v -l version \
    -n __fish_is_first_arg \
    -d "Print the version and exit."

# `yabai -V`
# `yabai --verbose`
complete -x -c yabai -s V -l verbose \
    -n __fish_is_first_arg \
    -d "Output debug information to stdout."
complete -x -c yabai -l uninstall-sa \
    -n __fish_is_first_arg \
    -d "Uninstall the scripting-addition. Must be run as root."
complete -x -c yabai -l load-sa \
    -n __fish_is_first_arg \
    -d "Load the scripting-addition into Dock.app."

# `yabai -c`
# `yabai --config`
complete -F -r -c yabai -s c -l config \
    -n __fish_is_first_arg \
    -d "Use the specified configuration file."

# `yabai -m`
# `yabai --message`
complete -x -c yabai -s m -l message \
    -n __fish_is_first_arg \
    -d "Send message to a running instance of yabai."

set -l message_domains '
config\tGet or set the value of <global setting>
display\tControl the given display
space\tControl the given space
window\tControl the given window
query\tRetrieve information about displays, spaces or windows
rule\tAdd, remove, or list rules
signal\tReact to some event that has been processed
'

complete -c yabai \
    -n "__fish_seen_argument -s m -l message" \
    -n "not __fish_seen_subcommand_from (__yabai_echo_argspec -k '$message_domains')" \
    -a "(__yabai_echo_argspec \"$message_domains\")"

# `yabai -m config --space <ARG>`
set -l space_selectors '
prev\tPrevious space
next\tNext space
first\tFirst space
last\tLast space
recent\tMost recently visited space
'

complete -c yabai \
    -n "__fish_seen_argument -s m -l message" \
    -n "__fish_seen_argument config" \
    -n "__fish_prev_arg_in --space" \
    -a "(__yabai_echo_argspec \"$space_selectors\")" \
    -d "Get or set the value of <space setting>"

# `yabai -m config [--space=] <ARG>`
set -l config_settings '
debug_output\tEnable output of debug information to stdout.
mouse_follows_focus\tWhen focusing a window, put the mouse at it\'s center.
'

complete -x -c yabai \
    -n "__fish_seen_argument -s m -l message" \
    -n "__fish_seen_subcommand_from config" \
    -n "not __fish_seen_argument -l space" \
    -n "not __fish_seen_subcommand_from (__yabai_echo_argspec -k \"$config_settings\")" \
    -a "--space\t'Get or set the value of <space setting>'"

complete -x -c yabai \
    -n "__fish_seen_argument -s m -l message" \
    -n "__fish_seen_subcommand_from config" \
    -n "not __fish_prev_arg_in --space" \
    -n "not __fish_seen_subcommand_from (__yabai_echo_argspec -k \"$config_settings\")" \
    -a "(__yabai_echo_argspec \"$config_settings\")"

# `yabai -m config debug_output <ARG>`
set -l boolean_values '
on\tEnable option
off\tDisable option
'

complete -x -c yabai \
    -n "__fish_seen_argument -s m -l message" \
    -n "__fish_seen_subcommand_from config" \
    -n "__fish_prev_arg_in debug_output" \
    -a "(__yabai_echo_argspec \"$boolean_values\")"
