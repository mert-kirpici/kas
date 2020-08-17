
_kas_find_ymls()
{
	find -maxdepth 1 \( -iname "*.yml" -o -iname "*.yaml" \) -exec basename {} \;
}

_kas()
{
	local cur prev subcommands commonargs
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	subcommands="build shell"
	commonargs="-h --version -d --debug"
	
	case "${prev}" in
		build)
			local args="-h --skip --force-checkout --update --target -c"
			local ymls=$(_kas_find_ymls)
			COMPREPLY=( $(compgen -W "${args} ${ymls}" -- ${cur}) )
			return 0
			;;
		shell)
			local ymls=$(_kas_find_ymls)
			COMPREPLY=( $(compgen -W "${ymls}" -- ${cur}) )
			return 0
			;;
		*)
			COMPREPLY=( $(compgen -W "${subcommands} ${commonargs}" -- ${cur}) )
			return 0
			;;
	esac
}
complete -F _kas kas
