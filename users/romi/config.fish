set homepath "$HOME/bin"
set homelocal "$HOME/.local"

set -q PATH; or set PATH ''; set -gx PATH $homepath $PATH
set -q PATH; or set PATH ''; set -gx PATH $PATH "$homelocal/zig" "$homelocal/zls"
set -q PATH; or set PATH ''; set -gx PATH $PATH "$homelocal/janet/bin"
set -q PATH; or set PATH ''; set -gx PATH $PATH "$PLAN9/bin"

# Mainly for work, can't wait to get rid of homebrew
eval "$(/opt/homebrew/bin/brew shellenv)";

# HINT: vis-editor needs to find its libs
function load_luarocks_paths
    eval "$(luarocks path --bin)"
end

function fish_prompt --description 'Write out the prompt'
    prompt $status
end

function load_work_stash
    # TODO: asdf and brew begone
    . "$HOME"/.asdf/asdf.fish
    source "$(brew --prefix)/share/google-cloud-sdk/path.fish.inc"
    rubocop --start-server
end

function load_opam
    eval "$(opam env)"
end

function load_zig_stable
    # TODO: Manage this with flakes
    set -q PATH; or set PATH ''; set -gx PATH "$homelocal"/zig-0.11.0 $PATH
end

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
