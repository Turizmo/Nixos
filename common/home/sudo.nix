{ ... }:
{	
  imports = [ 
    ./nixvim/nixvim.nix	# Install and configure neovim editor
  ];
  programs = {
    alacritty.enable = true; # Terminal emulatior
    yazi = { # Terminal-based filebrowser
      enable = true;
      initLua = ./yazi_init.lua;
      keymap = {
        manager.prepend_keymap = [
          {  on = [ "m" "m" ]; run = "linemode mtimev2"; desc = "Set linemode to modified time"; }
          {  on = [ "m" "c" ]; run = "linemode ctimev2"; desc = "Set linemode to created time"; }
        ];
      };
      settings = {
        manager = {
          show_hidden = true;
        };
      };
    };
    fd.enable = true; # Search
    ripgrep.enable = true; # Regex search    
    fzf.enable = true; # Fuzzy search
    zoxide.enable = true; # Navigate to frequently used directories
    jq.enable = true; # Terminal JSON processor

    #Enable and configure micro editor
    micro = {
      enable = true;
      settings = {
        "colorscheme" = "darcula";
        "tabsize" = 2;
        "softwrap" = true;
      };
    };
  }; 

  home.stateVersion = "24.05"; # Is set here because it must be defined for all home-manager users.

}

  
