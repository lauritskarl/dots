$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 1_000_000
$env.config.show_banner = false
$env.config.rm.always_trash = true
$env.config.edit_mode = "vi"
$env.config.completions.algorithm = "fuzzy"
$env.config.use_kitty_protocol = true
$env.config.footer_mode = "auto"

$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""

{{ if eq .chezmoi.os "darwin" -}}
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
{{ end -}}

mkdir ($nu.data-dir | path join "vendor/autoload")
mise activate nu | save -f ($nu.data-dir | path join "vendor/autoload/mise.nu")
mise exec -- starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
mise exec -- zoxide init nushell --cmd cd | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

$env.SHELL = "nu"
$env.EDITOR = "hx"
$env.VISUAL = "zed"
$env.PAGER = "bat"

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

alias ls = eza --long --icons --hyperlink --all --group-directories-first --smart-group --git --git-repos
alias ll = ls
alias la = ls
alias lt = eza --long --icons --hyperlink --all --group-directories-first --git-ignore --ignore-glob=.git --smart-group --git --git-repos --tree --level
alias cm = chezmoi
alias lg = lazygit
alias ld = lazydocker
alias lj = lazyjournal
alias oc = opencode
