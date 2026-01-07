# Homebrew on Linux
{{ if eq .chezmoi.os "linux" -}}
$env.HOMEBREW_PREFIX = "/home/linuxbrew/.linuxbrew"
$env.HOMEBREW_CELLAR = "/home/linuxbrew/.linuxbrew/Cellar"
$env.HOMEBREW_REPOSITORY = "/home/linuxbrew/.linuxbrew/Homebrew"
$env.PATH = ($env.PATH | prepend "/home/linuxbrew/.linuxbrew/bin" | prepend "/home/linuxbrew/.linuxbrew/sbin")
$env.MANPATH = ($env.MANPATH? | default "" | prepend "/home/linuxbrew/.linuxbrew/share/man")
$env.INFOPATH = ($env.INFOPATH? | default "" | prepend "/home/linuxbrew/.linuxbrew/share/info")
{{ end -}}

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

mkdir ($nu.data-dir | path join "vendor/autoload")
mise activate nu | save -f ($nu.data-dir | path join "vendor/autoload/mise.nu")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
zoxide init nushell --cmd cd | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

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
