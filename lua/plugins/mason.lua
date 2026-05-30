-- Auto-install Mason packages for LazyVim
return {
    "mason-org/mason.nvim",
    opts = {
        ensure_installed = {
            "google-java-format",
            "java-debug-adapter",
            "java-test",
            "sqlfluff",
        },
    },
}
