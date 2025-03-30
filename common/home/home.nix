{pkgs, lib, config, myUserName, ... }:
{	
  imports = [ 
    ./sudo.nix # Import configuration that is also used for sudo programs
    ./get-wallpaper.nix # Fetch wallpaper from wallhaven
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = myUserName;
    homeDirectory = "/home/${myUserName}";

    packages = with pkgs; [
      # tools
      ncdu # Disk usage analazyer
      nerdfonts # Iconfont for correct display of icons
      cifs-utils # SMB shares
      lsof # Tool to list open files
      psmisc # utils
      xfce.thunar # file navigator

      # tools for yazi
      ffmpegthumbnailer # preview of multimedia files
      ffmpeg # playback of multimedia files
      poppler # PDF viewer
      imagemagick # Terminal image editor/converter
      p7zip # 7-zip Archiver
      (python3.withPackages (ps: with ps; [ 
        numpy # Math stuff
        ha-decrypt-backup-tool # Homeassistant decrypton tool
      ]))

      
      megacmd # Cloud sync with MEGA drive. Login command: mega-login username password. Sync command: mega-sync local-repository remote-repository

      # installs libreoffice and spellcheck
      libreoffice-qt
      hunspell
      hunspellDicts.nb_NO

      openscad-unstable # parametric 3D-modeler

      orca-slicer # Slices files for 3D-printing 
        
      qmk # Firmware for keyboards

      openhantek6022 # Software for oscilloscope
      git
    ];
  };

  home.activation.bosl2 = lib.hm.dag.entryAfter [ "writeBoundary" "installPackages" "git" ] ''
     PATH="${config.home.path}/bin:$PATH" run git clone https://github.com/BelfrySCAD/BOSL2.git ${config.home.homeDirectory}/.local/share/OpenSCAD/libraries/BOSL2
  '';


  programs = {
    lazygit.enable = true; # GUI for git
    git = { # File versioning system
      enable = true;
      userName = "Turizmo";
      userEmail = "stianfoss.90+github@gmail.com";
    };
  };
  # For pushing to github you need to configure an SSH key manually
  # Check if you already have a generated key by lookin for this file: ~/.ssh/id_rsa.pub
  # If the key does not exist you can generate a key by running this command in the terminal: ssh-keygen -t rsa -C "description"
  # Copy the the public key(~/.ssh/id_rsa.pub) into github (profile -> settings -> SSH and GPG keys -> New SSH key)
  # NB! Never share the private key(~/.ssh/id_rsa)
  # Add the private key to the ssh agent by running this command in the terminal: ssh-add ~/.ssh/id_rsa
  # Check current orginin with: git remote -v, if it retruns something like https://github.com/Username/repo, you need to set origin to SSH. 
  # Set origin to SSH with this command: git remote set-url origin git@github.com:username/repo.git
  # The first push must be done in the terminal afterwards you can use lazygit
}
