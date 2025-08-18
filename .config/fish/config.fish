if status is-interactive
    fish_add_path /opt/homebrew/bin
    set --global fish_greeting
    set --global fish_key_bindings fish_vi_key_bindings
    mise activate fish | source
    atuin init fish | source
    zoxide init fish --cmd cd | source
    starship init fish | source
end
