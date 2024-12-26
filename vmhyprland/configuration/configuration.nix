{ config, pkgs, inputs, myUserName, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../common/configuration/configuration.nix
  ];
    
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?


  # Install wmware-tools
  virtualisation.vmware.guest.enable = true;

  # mount vmware shared folder at boot
  system.fsPackages = [ pkgs.open-vm-tools ];
  fileSystems."/mnt/hgfs" = {  # the location where the shared folder is mounted
   device = ".host:/OneDrive"; # the configured name of the shared folder in wmware
   fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
   options = [ "umask=22" "allow_other" "auto_unmount" "uid=1000" "gid=100" "defaults" ]; 
  };

  # Enable simple display manager for automatic login to hyprland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = myUserName; 


  # Use hyprland as windowmanager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
    security.pam.services.hyprlock = {};
  
  # set environment variables for hyprland (not needed?)
  #  environment.variables = {
  #   WLR_RENDERER_ALLOW_SOFTWARE = "1";
  #    XDG_SESSION_TYPE = "wayland";
  #    SDL_VIDEODRIVER = "wayland";
  #    CLUTTER_BACKEND = "wayland";
  #    XDG_CURRENT_DESKTOP = "Hyprland";
  #    XDG_SESSION_DESKTOP = "Hyprland";
  #    GTK_USE_PORTAL = "Hyprland";
  #    NIXOS_XDG_OPEN_USE_PORTAL = "1"; 
  # };

}
