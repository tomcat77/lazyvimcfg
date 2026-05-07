-- Отключение progress notifications для jdtls через noice.nvim
return {
    {
        "folke/noice.nvim",
        opts = function(_, opts)
            opts.routes = opts.routes or {}

            -- Фильтруем progress notifications от jdtls
            table.insert(opts.routes, {
                filter = {
                    event = "lsp",
                    kind = "progress",
                    cond = function(message)
                        local client = vim.tbl_get(message.opts, "progress", "client")
                        return client == "jdtls"
                    end,
                },
                opts = { skip = true },
            })

            -- Фильтруем сообщения "Validate documents" и "Publish diagnostics"
            table.insert(opts.routes, {
                filter = {
                    event = "notify",
                    find = "validate",
                },
                opts = { skip = true },
            })

            table.insert(opts.routes, {
                filter = {
                    event = "notify",
                    find = "publish diagnostic",
                },
                opts = { skip = true },
            })

            -- Фильтруем сообщения с "Processing" от jdtls
            table.insert(opts.routes, {
                filter = {
                    event = "lsp",
                    kind = "progress",
                    find = "Processing",
                },
                opts = { skip = true },
            })

            return opts
        end,
    },
}
