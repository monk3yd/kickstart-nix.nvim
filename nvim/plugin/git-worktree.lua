if vim.g.did_load_gitworktree_plugin then
    return
end
vim.g.did_load_gitworktree_plugin = true

require("git-worktree").setup()
