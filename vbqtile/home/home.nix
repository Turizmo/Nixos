{config, pkgs, lib, inputs, myUserName, ... }:
{
  imports = [
    ../../common/home/home.nix
  ];

  home.packages = with pkgs; [
    xclip # Enables global clipbard
    rofi # Application launhcer
  ];
}   
