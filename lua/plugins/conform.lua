-- Formatter configuration for LazyVim
-- Uses google-java-format for Java (matches IntelliJ IDEA style)
return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      java = { "google-java-format" },
    },
    formatters = {
      ["google-java-format"] = {
        meta = {
          url = "https://github.com/google/google-java-format",
          description = "Reformats Java source code according to Google's style (matches IntelliJ IDEA defaults).",
        },
        prepend_args = { "--aosp" },
      },
    },
  },
}
