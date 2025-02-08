{ ... }:
{   
  programs.nixvim = {
    extraConfigLua = ''
      vim.keymap.set("n", "<space>", "<Nop>", { silent = true, remap = false })				-- Map leader to space
      vim.g.mapleader = " "										-- Map leader to space
      vim.api.nvim_set_keymap('n', '<Leader>y', '"+y', { noremap = true, silent = false }) 		-- Map copy to clipboard in nomral mode.
      vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', { noremap = true, silent = false }) 		-- Map copy to clipboard in visual mode.
      vim.api.nvim_set_keymap('n', '<Leader>p', '"+p', { noremap = true, silent = false }) 		-- Map paste from clipboard in normal mode.
      vim.api.nvim_set_keymap('n', '<Leader>w', ':wa<CR>', { noremap = true, silent = false }) 		-- Map write file.
      vim.api.nvim_set_keymap('n', '<Leader>q', ':NvimTreeClose|:q<CR>', { noremap = true, silent = false }) 	-- Map quit.
      vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeFocus<CR>', { noremap = true, silent = false }) 	-- Map TreeToggle.
      vim.api.nvim_set_keymap('n', '<Leader>g', ':LazyGit<CR>', { noremap = true, silent = false }) 	-- Map LazyGit.
      vim.api.nvim_set_keymap('n', '<Leader>o', ':!openscad % &<CR>', { noremap = true, silent = true }) 	-- Map Openscad.
    '';
  };
}
