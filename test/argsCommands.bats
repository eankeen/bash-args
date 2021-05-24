#!/usr/bin/env bats
set -Eeuo pipefail

source ./bin/args-init

@test "argsCommands is correct basic" {
	declare -A args
	declare -a argsCommands=()

	args.parse alfa bravo <<-'EOF'
	@flag [port.p] {3000} - The port to open on
	EOF

	[[ "${#argsCommands[@]}" = 2 ]]
	[[ "${argsCommands[0]}" = alfa ]]
	[[ "${argsCommands[1]}" = bravo ]]
}


@test "argsCommands is correct advanced" {
	declare -A args
	declare -a argsCommands=()

	args.parse --port 3005 serve --user admin now --enable-security <<-'EOF'
	@flag [port.p] {3000} - The port to open on
	EOF

	[[ "${#argsCommands[@]}" = 2 ]]
	[[ "${argsCommands[0]}" = serve ]]
	[[ "${argsCommands[1]}" = now ]]
}

@test "argsCommands works with boolean flags" {
	declare -A args
	declare -a argsCommands=()

	args.parse --port 3005 serve now --enable-security last <<-'EOF'
	@flag [port.p] {3000} - The port to open on
	@flag [enable-security] - Whether to enable security
	EOF

	[[ "${#argsCommands[@]}" = 3 ]]
	[[ "${argsCommands[0]}" = serve ]]
	[[ "${argsCommands[1]}" = now ]]
	[[ "${argsCommands[2]}" = last ]]
}
