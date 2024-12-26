{config, pkgs, lib, inputs, myUserName, ... }:
{	
  imports = [ 
    ./sudo.nix # Import configuration that is also used for sudo programs
    ./get-wallpaper.nix # Fetch wallpaper from wallhaven
  ];

  home.username = myUserName;
  home.homeDirectory = "/home/${myUserName}";



  home.packages = with pkgs; [
    # tools
    ncdu # Disk usage analazyer
    nerdfonts # Iconfont for correct display of icons
    cifs-utils # SMB shares
    fzf # fuzzy finder
    lsof # Tool to list open files
    psmisc # utils
    
    lazygit # Graphical interface for git

    yazi    # Terminal-based filebrowser

    megacmd # Cloud sync with MEGA drive

    # installs libreoffice and spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.nb_NO

    openscad-unstable # parametric 3D-modeler
    orca-slicer # Slices files for 3D-printing 
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
