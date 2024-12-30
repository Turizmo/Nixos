{ pkgs, lib, ... }:
{
  imports = [
    ../../common/home/home.nix
    ../../common/home/hyprland.nix # Install and configure hyprland tiling window manager and other desktop widgets compatible with hyprland.
  ];

  programs.wofi.enable = true;
  programs.waybar.enable = true;
  services.swaync.enable = true;
  #programs.hyprlock.enable = true;

  services.hyprpaper.enable = lib.mkForce false; # There is bug that in the hyprpaper service that enables it permanently if it has been enabled once on the system. This forces the service off. swww is used for setting wallpapers instead

  home.packages = with pkgs; [
    swayimg # Image viewer for wayland
    swww  # Setting wallpapers for wayland
    wlr-randr # Display info for wayland

    # installs python with spesified packages
    (python311.withPackages (ps: with ps; [
      numpy # these two are
      scipy # probably redundant to pandas
      jupyterlab
      pandas
      statsmodels
      #scikitlearn
    ]))

  ];
}   
