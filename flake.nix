{
  description = "Kassio's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = { url = "github:nix-community/nixvim"; };
    # Only the Lua library (init.lua) is used, so skip its flake inputs
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      flake = false;
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, aagl, stylix, home-manager, nixvim, ... }:
    let
      system = "x86_64-linux";
      # Shared modules for all hosts
      sharedModules = [
        ./common/configuration.nix
        aagl.nixosModules.default
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
        {
          nixpkgs.config.allowUnfree = true;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
          programs.anime-game-launcher.package =
            aagl.packages.${system}.anime-game-launcher;
        }
      ];
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ [
            ./laptop/configuration-laptop.nix
            { home-manager.users.kassio = import ./home/home-laptop.nix; }
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ [
            ./desktop/configuration-desktop.nix
            { home-manager.users.kassio = import ./home/home-desktop.nix; }

          ];
        };
      };
    };
}
