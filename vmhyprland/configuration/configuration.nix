{ config, pkgs, inputs, ... }:
{
  imports = [
    ../../common/configuration/configuration.nix
  ];

  # Install wmware-tools
  virtualisation.vmware.guest.enable = true;

  # mount vmware shared folder at boot
  system.fsPackages = [ pkgs.open-vm-tools ];
  fileSystems."/mnt/hgfs" = {
   device = ".host:/OneDrive";
   fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
   options = [ "umask=22" "allow_other" "auto_unmount" "uid=1000" "gid=100" "defaults" ]; 
  };
}
