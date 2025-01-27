{ lib, ... }:
{	
  imports = [ 
    ./nixvim/nixvim.nix	# Install and configure neovim editor
    ./yazi.nix # Install and configure yazi directory navigator
  ];
  programs = {
    alacritty.enable = true; # Terminal emulatior
    fd.enable = true; # Search
    ripgrep.enable = true; # Regex search    
    fzf.enable = true; # Fuzzy search
    zoxide.enable = true; # Navigate to frequently used directories
    jq.enable = true; # Terminal JSON processor
    tealdeer.enable = true;

    #Enable and configure micro editor
    micro = {
      enable = true;
      settings = {
        "colorscheme" = lib.mkForce "darcula";
        "tabsize" = 2;
        "softwrap" = true;
      };
    };
  }; 

  home.stateVersion = "24.05"; # Is set here because it must be defined for all home-manager users.

}

  
