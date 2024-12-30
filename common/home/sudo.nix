{ ... }:
{	
  imports = [ 
    ./nixvim.nix	# Install and configure neovim editor
  ];
    
  #Enable and configure micro editor
  programs.micro = {
    enable = true;
    settings = {
      "colorscheme" = "darcula";
      "tabsize" = 2;
      "softwrap" = true;
    };
  };
 

  home.stateVersion = "24.05"; # Is set here because it must be defined for all home-manager users.

}

  
