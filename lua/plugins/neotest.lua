return {
    {
        "nvim-neotest/neotest",
        opts = {
            adapters = {
                ["neotest-java"] = {
                    jvm_args = { "-Dapi.version=1.44" },
                    env = { API_VERSION = "1.44" },
                },
            },
        },
    },
}

