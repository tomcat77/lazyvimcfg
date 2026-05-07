-- Java LSP + DAP (Maven / Spring Boot)
-- extras: dap.core + lang.java в lua/config/lazy.lua
-- Фильтрация уведомлений: lua/plugins/noice.lua
--
-- Отладка Spring Boot через attach: поднимите приложение с JDWP, затем <leader>dc → выберите конфиг.
-- Пример (Maven, порт 5005):
--   ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"
-- Либо «Launch» из jdtls: <leader>dc → конфиги main-класса подставляются после LspAttach.

return {
    {
        "mfussenegger/nvim-jdtls",
        dependencies = { "mfussenegger/nvim-dap" },
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
    -- Доп. attach-порты после preset из lazyvim.plugins.extras.lang.java (порт 5005).
    {
        "mfussenegger/nvim-dap",
        opts = function(_, opts)
            local dap = require("dap")
            dap.configurations.java = dap.configurations.java or {}
            vim.list_extend(dap.configurations.java, {
                {
                    type = "java",
                    request = "attach",
                    name = "Java: attach localhost:8000",
                    hostName = "127.0.0.1",
                    port = 8000,
                },
            })
            return opts
        end,
    },
}
