require("cmake").setup { cmake = { parallel_jobs = #vim.uv.cpu_info() } }
