return {
  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "nvim-neotest/neotest",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      -- Initialize adapter so :NeotestJava setup works after opening a .java file
      require("neotest-java")
    end,
  },
}
