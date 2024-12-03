{ pkgs, ... }:
{	
  #configure micro
  programs.micro = {
    enable = true;
    settings = {
      "colorscheme" = "darcula";
      "tabsize" = 2;
      "softwrap" = true;
    };
  };
  
  home.stateVersion = "25.05";
}

  
