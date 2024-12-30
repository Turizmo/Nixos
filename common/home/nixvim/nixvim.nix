{ ... }:
{
  imports= [
    ./nixvim-lua.nix # Custom keybindings and LUA configuration of neovim
    ./nixvim-plugins.nix # Install plugins for neovim
  ];

  stylix.targets.nixvim.enable = false; # Disable stylix for nixvim so that nixvim can use a proper theme

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.catppuccin = { # theme must be set here in addition to stylix, otherwise syntax highlighting does not work properly
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = true;
      };
    };
    # colorschemes.rose-pine = {
    #   enable = true;
    #   settings = {
    #     styles = {
    #       transparency = true;
    #     };
    #   };
    # };
   # colorschemes.nord.enable = true;
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
