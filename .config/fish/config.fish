if status is-interactive
    set --global fish_greeting
    set --global fish_key_bindings fish_vi_key_bindings
    set --global --export SHELL fish
    set --global --export EDITOR hx
    set --global --export PAGER bat
    set --global --export _ZO_ECHO 1
    mise activate fish | source
    atuin init fish | source
    zoxide init fish --cmd cd | source
    starship init fish | source
end
