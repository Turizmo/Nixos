{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, home-manager, nixvim, stylix, ... } @ inputs: 
    let
      mkSystem = mySystem: myHostName: myUserName: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; 
          specialArgs = { inherit inputs; };
          modules = [
            { networking.hostName = myHostName; }
            ./vmhyprland/configuration/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ];
              home-manager.users.nixos = import ./vmhyprland/home/home.nix;
              home-manager.users.root = import ./common/home/sudo.nix;
            }
            inputs.stylix.nixosModules.stylix
          ];
        };
    in {
      nixosConfigurations = {
        vmhyprland = mkSystem "x86_64-linux" "vmhyprland" "nixos";
      };
    };

}
