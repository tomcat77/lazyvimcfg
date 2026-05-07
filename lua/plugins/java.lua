-- Java LSP configuration with Lombok support
-- Дополнительная настройка nvim-jdtls после загрузки lazyvim.plugins.extras.lang.java
-- Импорт extras.lang.java находится в lua/config/lazy.lua
-- Фильтрация уведомлений настроена в lua/plugins/noice.lua

return {
    {
        "mfussenegger/nvim-jdtls",
        opts = function(_, opts)
            -- Получаем путь к Mason
            local mason_path = vim.fn.stdpath("data") .. "/mason"
            local lombok_jar = mason_path .. "/share/jdtls/lombok.jar"

            -- Инициализируем cmd если его нет
            opts.cmd = opts.cmd or {}

            -- Проверяем, что Lombok jar существует
            if vim.fn.filereadable(lombok_jar) == 1 then
                -- Проверяем, есть ли уже Lombok в cmd
                local has_lombok = false
                for _, arg in ipairs(opts.cmd) do
                    if arg:find("lombok", 1, true) then
                        has_lombok = true
                        break
                    end
                end

                -- Добавляем Lombok, если его ещё нет
                if not has_lombok then
                    local lombok_arg = string.format("-javaagent:%s", lombok_jar)
                    table.insert(opts.cmd, "--jvm-arg=" .. lombok_arg)
                end
            end

            return opts
        end,
    },
}
