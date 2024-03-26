{
  description = "The jankiest NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    lix = {
      url = "git+ssh://git@lix.systems/lix-project/lix";
      flake = false;
    };

    lix-module = {
      url = "git+ssh://git@lix.systems/lix-project/nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.lix.follows = "lix";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [ ./configuration.nix
                  ./hardware-configuration.nix
                  ./fonts.nix
                  ./packages.nix
                  inputs.lix-module.nixosModules.default
                ];
    };
  };
}
