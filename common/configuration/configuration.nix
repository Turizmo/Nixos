{ pkgs, ... }:
{
  
    # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;


    # Enable networking
    networking.networkmanager.enable = true;
    networking.networkmanager.dns = "none";
    networking.nameservers = ["8.8.8.8" "8.8.4.4"];
    
    # Set your time zone.
    time.timeZone = "Europe/Oslo";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "nb_NO.UTF-8";
      LC_IDENTIFICATION = "nb_NO.UTF-8";
      LC_MEASUREMENT = "nb_NO.UTF-8";
      LC_MONETARY = "nb_NO.UTF-8";
      LC_NAME = "nb_NO.UTF-8";
      LC_NUMERIC = "nb_NO.UTF-8";
      LC_PAPER = "nb_NO.UTF-8";
      LC_TELEPHONE = "nb_NO.UTF-8";
      LC_TIME = "nb_NO.UTF-8";
    };

    # Set keyboard layout
   services.xserver.xkb.layout = "no";

   nix.settings.experimental-features = [ "nix-command" "flakes" ];

   home-manager.backupFileExtension = "backup2";

   stylix = {
    enable = true;
    base16Scheme ="${pkgs.base16-schemes}/share/themes/rose-pine.yaml"; # Theme is also set in nixvim NB! not all themes are available in nixvim, so it can be difficult to find themes that are available both in base16-schemes and nixvim
    image = /home/nixos/Wallpaper/wallhaven.jpg;
    polarity = "dark";
    opacity = {
      applications = 0.9;
      desktop = 0.9;
      popups = 0.9;
      terminal = 0.9;
    };
    targets = {
      nixvim.enable = false;
    };
  };

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
    pciutils  # information about PCI devices 
    usbutils  # Automount usb drive
    udiskie   # Automount usb drive
    udisks   # Automount usb drive
	];

  # Configure console keymap
  console.keyMap = "no";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixos = {
    isNormalUser = true;
    description = "NixOS";
    extraGroups = [ "networkmanager" "wheel" "vboxsf" "dialout"];   # vboxsf is only reqired for virtual shared folders on guests
    packages = with pkgs; [
    #  thunderbird
    ];
  };

   # Install firefox.
  programs.firefox.enable = true;

  # Set the default editor
  environment.variables.EDITOR = "nvim";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.ssh.startAgent = true;

  nix.settings.download-buffer-size = 104857600; # set download buffer to 100MB, errors can occur while building with the default buffer size


  # Enable automounting of USB drives
  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
  };
services.udev.extraRules = ''
# rules for OpenHantek6022 (DSO program) as well as Hankek6022API (python tools)
ACTION!="add|change", GOTO="openhantek_rules_end"
SUBSYSTEM!="usb|usbmisc|usb_device", GOTO="openhantek_rules_end"
ENV{DEVTYPE}!="usb_device", GOTO="openhantek_rules_end"

# Hantek DSO-6022BE, without FW, with FW
ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="6022", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"
ATTRS{idVendor}=="04b5", ATTRS{idProduct}=="6022", TAG+="uaccess", TAG+="udev-acl", MODE="660", GROUP="plugdev"
LABEL="openhantek_rules_end"

# Arduino pro micro
# SUBSYSTEM=="usb", ATTRS{idVendor}=="0036", ATTRS{idProduct}=="2341", MODE="0666", GROUP="dialout"
'';
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

   

}
