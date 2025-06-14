{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { # Configuration of userspace
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = { # Neovim editor configurable by nix syntax
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = { # Systemwide themes
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # bosl2.url = "github:BelfrySCAD/BOSL2";
  };

  outputs = { self, nixpkgs, unstable, home-manager, nixvim, stylix, ... } @ inputs: 
    let
      mkSystem = {mySystem, myHostName, myUserName}: nixpkgs.lib.nixosSystem {
          system = mySystem; 
          specialArgs = { inherit inputs; inherit myUserName; };
          modules = [
            { networking.hostName = myHostName; }
            ./${myHostName}/configuration/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; inherit myUserName;};
            # home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ];  
              home-manager.users.${myUserName} = import ./${myHostName}/home/home.nix;
              home-manager.users.root = import ./common/home/sudo.nix;
            }
            inputs.stylix.nixosModules.stylix
          ];
        };
    in {
      nixosConfigurations = {
        vmhyprland = mkSystem {
          mySystem = "x86_64-linux";
          myHostName = "vmhyprland";
          myUserName = "nixos";
        };
        vbqtile = mkSystem {
          mySystem = "x86_64-linux";
          myHostName = "vbqtile";
          myUserName = "nixos";
        };

      };
    };

}
