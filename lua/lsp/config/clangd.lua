require'lspconfig'.clangd.setup{
	cmd = {
		"clangd", "--background-index", "--pch-storage=memory",
		"--clang-tidy", "--suggest-missing-includes", "--all-scopes-completion",
		"--clang-tidy-checks=performance-*,bugprone-*",
		"--compile-commands-dir=build"
	},	
}
