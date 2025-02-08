{ pkgs, ... }:
{
  imports = [
    ../../common/home/home.nix
  ];

  home.packages = with pkgs; [
    xclip # Enables global clipbard
  ];

  programs = {
    rofi.enable = true; # Application launhcer
  };  
}   
