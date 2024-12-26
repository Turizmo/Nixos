{config, pkgs, lib, inputs, myUserName, ... }:
{
  imports = [
    ../../common/home/home.nix
  ];

  home.packages = with pkgs; [
  ];
}   
