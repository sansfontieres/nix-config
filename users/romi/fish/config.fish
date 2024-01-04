set -q PATH; or set PATH ''; set -gx PATH $SYMLINK_PATH $PATH
set -q PATH; or set PATH ''; set -gx PATH $SCRIPT_PATH $PATH
set -q PATH; or set PATH ''; set -gx PATH $BIN_PATH $PATH
set -q PATH; or set PATH ''; set -gx PATH $PATH "$PLAN9/bin"

set -gx EZA_COLORS "oc=2:ur=2:uw=2:ux=2:ue=2:gr=2:gw=2:gx=2:tr=2:tw=2:su=2:sf=2:xa=2:uu=2:uR=1:un=2;1:gu=2:sn=2:sb=2:da=2"

set -gx EZA_TIME_STYLE "+%y-%m-%dT%H·%M"
# delete comments once eza manages multi-style-format
#  %m-%dT%H·%M"

# nix-darwin overwrites XDG_DATA_DIRS and tempers with Ghostty
# auto-injection, so we have to source it manually.
if set -q GHOSTTY_RESOURCES_DIR
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

# HINT: vis-editor needs to find its libs
function load_luarocks_paths
    eval "$(luarocks path --bin)"
end

function fish_prompt --description 'Write out the prompt'
    prompt $status
end

function load_opam
    eval "$(opam env)"
end

# I beg you to stop
set -Ue fish_greeting
function fish_greeting; end

set -U fish_color_normal normal
set -U fish_color_command normal
set -U fish_color_keyword  --italics --bold
set -U fish_color_quote green
set -U fish_color_redirection brblack
set -U fish_color_end brblack
set -U fish_color_error red
set -U fish_color_param normal
set -U fish_color_valid_path --underline
set -U fish_color_option normal
set -U fish_color_comment --italics brblack
set -U fish_color_selection --background=e2e3fa
set -U fish_color_operator blue
set -U fish_color_escape bryellow --dim
set -U fish_color_autosuggestion white --dim
# set -U fish_color_cwd green
# set -U fish_color_cwd_root red
# set -U fish_color_user brgreen
# set -U fish_color_host normal
# set -U fish_color_host_remote normal
# set -U fish_color_status red
set -U fish_color_cancel --reverse
# set -U fish_color_search_match --background=blue

# set -U fish_color_history_current --bold

set -U fish_pager_color_progress brmagenta --background=white
set -U fish_pager_color_background --background=background
set -U fish_pager_color_prefix --underline
set -U fish_pager_color_completion normal
set -U fish_pager_color_description --italics brblack
set -U fish_pager_color_selected_background --background=white
set -U fish_pager_color_selected_prefix magenta --bold
set -U fish_pager_color_selected_completion normal

# set -U fish_pager_color_selected_description
set -U fish_pager_color_secondary_background --background=brwhite
# set -U fish_pager_color_secondary_prefix
# set -U fish_pager_color_secondary_completion --background=brwhite
# set -U fish_pager_color_secondary_description
