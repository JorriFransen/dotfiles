{
  description = "Home Manager configuration of jorri";

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

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nur, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."jorri" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
            # { nixpkgs.config.allowUnfree = true; }
            ./home.nix
            nur.nixosModules.nur
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix

        extraSpecialArgs = {
          inherit system;

          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
      };
    };
}
