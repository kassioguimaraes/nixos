{
  description = "Kassio's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
  };

  outputs = inputs@{ self, nixpkgs, stylix, home-manager, nixvim, ... }:
    let
      system = "x86_64-linux";
      # Shared modules for all hosts
      sharedModules = [
	./common/configuration.nix
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
        {
          nixpkgs.config.allowUnfree = true;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            nixvim.homeModules.nixvim
            inputs.noctalia.homeModules.default
          ];
        }
      ];
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ [
	 ./laptop/configuration-laptop.nix
	{
		  home-manager.users.ksgm = import ./home/home-laptop.nix;
	}
 ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ [
 ./desktop/configuration-desktop.nix
{
          home-manager.users.kassio = import ./home/home-desktop.nix;
}

 ];
        };
      };
    };
}
