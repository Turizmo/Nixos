{ pkgs, ... }:
{
  imports = [
    ../../common/home/home.nix
  ];

  home.packages = with pkgs; [
    xclip # Enables global clipbard
    # rofi # Application launhcer
  ];

  programs = {
    rofi.enable = true;
  };  
}   
