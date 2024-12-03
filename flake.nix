{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
		# hyprland = { # Tiling window manager
  #     url = "github:hyprwm/hyprland";
  #     inputs.nixpkgs.follows = "nixpkgs";
		# };
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
		nixvim = { # Neovim editor configurable by nix syntax
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs"; 
    };
    stylix = { # Systemwide colorsstyles
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager,/*  hyprland, */ nixvim, ... } @inputs: {
    nixosConfigurations = {
      # TODO please change the hostname to your own
      nixos = nixpkgs.lib.nixosSystem {
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
