{
  description = "I made my NixOS even more Jankier!";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixpkgs, lanzaboote, ... }@inputs: {
    nixosConfigurations."nix-floater" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          lanzaboote.nixosModules.lanzaboote
          ./modules/lanza.nix
          ./modules/fonts.nix
        ];
      };
  };
}
