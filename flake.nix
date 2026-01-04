{
  description = "Kassio's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };

  outputs = { self, nixpkgs, home-manager,nixvim, ... }:
  let
    system = "x86_64-linux";
  in {
          nixpkgs.config.allowUnfree = true;
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];

          home-manager.users.ksgm =
            import ./users/ksgm/home.nix;
        }
      ];
    };
  };
}
