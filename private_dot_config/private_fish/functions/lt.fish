function lt --description 'Tree listing with eza'
    set -l level 2
    if test (count $argv) -gt 0; and string match -qr '^\d+$' -- $argv[1]
        set level $argv[1]
        set -e argv[1]
    end
    eza --long --tree --icons --hyperlink --level=$level --all --group-directories-first --git-ignore --ignore-glob=.git --smart-group --git --git-repos $argv
end
