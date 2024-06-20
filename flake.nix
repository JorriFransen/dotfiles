{
  description = "My nix config";

  inputs = {

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, nur, ... }:
    let
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
      pkgs-unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
      nur-no-pkgs = import nur { pkgs = pkgs; nurpkgs = pkgs; };
    in
    {

      nixosConfigurations = {

        slimbook = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit pkgs;
            };

            modules = [
              ./nixos/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = {
                  inherit pkgs pkgs-unstable nur-no-pkgs;
                };

                home-manager.users = {
                  jorri = import ./jorri.nix;
                  work = import ./work.nix;
                };
              }
            ];

        };

      };
    };

}
