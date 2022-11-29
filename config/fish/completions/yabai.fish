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
complete -x -c yabai -s v -l version -n __fish_is_first_arg \
    -d "Print the version and exit."

# `yabai -V`
# `yabai --verbose`
complete -x -c yabai -s V -l verbose -n __fish_is_first_arg \
    -d "Output debug information to stdout."

# `yabai --uninstall-sa`
complete -x -c yabai -l uninstall-sa -n __fish_is_first_arg \
    -d "Uninstall the scripting-addition. Must be run as root."

# `yabai --load-sa`
complete -x -c yabai -l load-sa -n __fish_is_first_arg \
    -d "Load the scripting-addition into Dock.app."

# `yabai -c`
# `yabai --config`
complete -r -c yabai -s c -l config -n __fish_is_first_arg \
    -d "Use the specified configuration file."

complete -F -r -c yabai -n "__fish_prev_arg_in -- -c --config" -a "(__fish_complete_path)"

# `yabai -m`
# `yabai --message`

set -l message_domains '
config\t"Get or set the value of <global setting>"
display\t"Control the given display"
space\t"Control the given space"
window\t"Control the given window"
query\t"Retrieve information about displays, spaces or windows"
rule\t"Add, remove, or list rules"
signal\t"React to some event that has been processed"
'

complete -x -c yabai -s m -l message -n "__fish_is_nth_token 1" \
    -a "$message_domains" \
    -d "Send message to a running instance of yabai."

# `yabai -m config --space <ARG>`
set -l space_selectors '
prev\t"Previous space"
next\t"Next space"
first\t"First space"
last\t"Last space"
recent\t"Most recently visited space"
\#\t"Mission control index (1-based)"
\"\"\t"Any arbitrary string used as a label"
'

function __yabai_at_space_selector
    __fish_seen_argument -s m -l message
    and not __fish_seen_argument config
    and __fish_prev_arg_in -- --space
    and return 0

    return 1
end

complete -c yabai -n __yabai_at_space_selector -a "$space_selectors" \
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
