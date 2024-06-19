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

    # nur.url = "github:nix-community/NUR";
  };

  outputs = { ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
      pkgs-unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
    in {

      nixosConfigurations = {

        slimbook = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs pkgs-unstable;
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./nixos/configuration.nix
          ];
        };

      };

     
    #   homeConfigurations."jorri" = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;

    #     # Specify your home configuration modules here, for example,
    #     # the path to your home.nix.
    #     modules = [
    #         ./home.nix
    #         nur.nixosModules.nur
    #     ];

    #     # Optionally use extraSpecialArgs
    #     # to pass through arguments to home.nix

    #     extraSpecialArgs = {
    #       inherit system;

    #       pkgs-unstable = import nixpkgs-unstable {
    #         inherit system;
    #         config.allowUnfree = true;
    #       };
    #     };
    #   };
    };
}
