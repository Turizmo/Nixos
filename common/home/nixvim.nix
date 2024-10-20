{config, pkgs, lib, inputs, ... }:
{
  imports= [
    ./nixvim-lua.nix # Custom keybindings and LUA configuration of neovim
    ./nixvim-plugins.nix # Install plugins for neovim
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin = { # theme must be set here in addition to stylix, otherwise syntax highlighting does not work properly
      enable = true; 
      settings = {
        flavour = "mocha";
        transparent_background = true;
      };
    };
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      termguicolors = true;
      background = "dark";
      signcolumn = "yes";
      splitright = true;
      splitbelow = true;
      smartindent = false;
      autoindent = false;
      cindent = false;
    };
  };
}
