{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Change this version to upgrade the system, there is a new release every 6 months. Expect that the configuration may break when upgrading. Remember to also change the release of the other inputs below.
    unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Use the unstable input instead of nixpkgs to fetch more up to date packages. Nixos-unstable breaks hyprland often, so it should not be used on system or critical packages. 

    home-manager = { # Used for managing user configuration 
      url = "github:nix-community/home-manager/release-24.11"; # Should have the same release number as nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
		nixvim = { # Neovim editor configurable by nix syntax
			url = "github:nix-community/nixvim/nixos-24.11"; # Should have the same release number as nixpkgs.
			inputs.nixpkgs.follows = "nixpkgs"; 
    };
    stylix = { # Systemwide colorsstyles
      url = "github:danth/stylix/release-24.11"; # Should have the same release number as nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, unstable, home-manager, nixvim, ... } @inputs: {
    nixosConfigurations = {
      # TODO please change the hostname to your own
      vmhyprland = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [

          ./common/configuration/configuration.nix
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [
                nixvim.homeManagerModules.nixvim
            ];
            home-manager.users.nixos = import ./common/home/home.nix; 
            home-manager.users.root = import ./common/home/sudo.nix; # home manager stateversion and config for programs that are usaually used with sudo
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
          inputs.stylix.nixosModules.stylix
        ];
      };

    };
  };
}
