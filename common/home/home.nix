{config, pkgs, lib, inputs, username, ... }:
{	
  imports = [ 
    ./sudo.nix # Import configuration that is also used for sudo programs
    ./hyprland.nix # Install and configure hyprland tiling window manager and other desktop widgets compatible with hyprland.
    ./nixvim.nix	# Install and configure neovim editor
    ./get-wallpaper.nix # Fetch wallpaper from wallhaven
    ./shared-clipboard.nix
  ];      

  programs.wofi.enable = true;
  programs.alacritty.enable = true;
  programs.waybar.enable = true;
  services.swaync.enable = true;
  #programs.hyprlock.enable = true;
  programs.obs-studio.enable = true;
  programs.ranger = {
    enable = true;
    plugins = [
      {
        name = "ranger-fzf.py";
        src = builtins.fetchGit {
          url = "https://github.com/cjbassi/ranger-fzf.git";
          rev = "a939633c146a98cd029ae0cc87b9b62cc7399bb2";
        };
      }
    ];
    settings = {
      show_hidden = true;
    };
  };

  services.hyprpaper.enable = lib.mkForce false; # There is bug that in the hyprpaper service that enables it permanently if it has been enabled once on the system. This forces the service off. swww is used for setting wallpapers instead

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.packages = with pkgs; [
    # xclip # Makes copy paste more reliable
    ncdu # Disk usage analazyer
    kitty	# Default terminal emulator	
    lazygit # Graphical interface for git
    wl-clipboard # Clipboard manager for wayland
    clipnotify # Notify when clipboard changes
    inotify-tools # Notify when file changes
    # installs python with spesified packages
    (python311.withPackages (ps: with ps; [
      numpy # these two are
      scipy # probably redundant to pandas
      jupyterlab
      pandas
      statsmodels
      #scikitlearn
    ]))
    #test
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
    ranger  # Terminal-based filebrowser (can be replaced by cfile if i compile it)
    nnn     # Terminal-based filebrowser 
    nerdfonts # Iconfont for correct display of icons
    cifs-utils # SMB shares
    psmisc # utils
    fzf # fuzzy finder
  ];

  fonts.fontconfig.enable = true;

  programs.git = {	
    enable = true;
    userName = "Turizmo";
    userEmail = "stianfoss.90+github@gmail.com";
  };
  # For pushing to github you need to configure an SSH key manually
  # Check if you already have a generated key by lookin for this file: ~/.ssh/id_rsa.pub
  # If the key does not exist you can generate a key by running this command in the terminal: ssh-keygen -t rsa -C "description"
  # Copy the the public key(~/.ssh/id_rsa.pub) into github (profile -> settings -> SSH and GPG keys -> New SSH key)
  # NB! Never share the private key(~/.ssh/id_rsa)
  # Add the private key to the ssh agent by running this command in the terminal: ssh-add ~/.ssh/id_rsa
  # The first push must be done in the terminal afterwards you can use lazygit
  
}
