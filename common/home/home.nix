{config, pkgs, lib, inputs, username, ... }:
{	
  imports = [ 
    ./sudo.nix # Import configuration that is also used for sudo programs
    ./hyprland.nix # Install and configure hyprland tiling window manager and other desktop widgets compatible with hyprland.
    ./nixvim.nix	# Install and configure neovim editor
    ./get-wallpaper.nix # Fetch wallpaper from wallhaven
  ];     

  programs.wofi.enable = true;
  programs.alacritty.enable = true;
  programs.waybar.enable = true;
  services.swaync.enable = true;
  programs.hyprlock.enable = true;
  programs.obs-studio.enable = true;
  programs.ranger = {
    enable = true;
    settings = {
      show_hidden = true;
    };
  };

  services.hyprpaper.enable = lib.mkForce false; # There is bug that in the hyprpaper service that enables it permanently if it has been enabled once on the system. This forces the service off. swww is used for setting wallpapers instead

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.packages = with pkgs; [
    # xclip # Makes copy paste more reliable
    kitty		
    lazygit
    wl-clipboard
    # installs python with spesified packages
    (python311.withPackages (ps: with ps; [
      numpy # these two are
      scipy # probably redundant to pandas
      jupyterlab
      pandas
      statsmodels
      scikitlearn
    ]))

    # installs libreoffice and spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.nb_NO

  #  hyprlock
    #  mako
    swayimg # Image viewer
    swww  # Setting wallpapers
    konsole
    wlr-randr 
    copyq # Clipboard manager
    xfce.thunar  
    dolphin
    ranger  # Terminal-based filebrowser
    nerdfonts # Iconfonts for correct display of icons
  ];

  fonts.fontconfig.enable = true;

  programs.git = {	
    enable = true;
    userName = "Turizmo";
    userEmail = "stianfoss.90+github@gmail.com";
  };
}