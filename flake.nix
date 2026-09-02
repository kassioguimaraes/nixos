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
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      #url = "github:sodiboo/niri-flake";
      url = "github:sodiboo/niri-flake?rev=6bb99ff875919f03ea6054026619d999061e1170";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, aagl, stylix, home-manager, nixvim, niri, ... }:
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
            niri.nixosModules.niri
            {
              nixpkgs.overlays = [ niri.overlays.niri ];
              home-manager.sharedModules = [ inputs.noctalia.homeModules.default ];
            }
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
