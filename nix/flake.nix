{
  description = "The jankiest NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    qemu-espressif.url = "github:SFrijters/nix-qemu-espressif";
  };

  outputs = { self, nixpkgs,  qemu-espressif, ... }@inputs:
    let
     system = "x86_64-linux";
      custom-overlays = final: prev: {
        unstable = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        pkgs-with-custom-pkgs = import nixpkgs {
          inherit system;
          overlays = [ qemu-espressif.overlay ];
        };
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs qemu-espressif; }; # Pass flake inputs to our config
        modules = [
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ custom-overlays ]; }) 
           ./configuration.nix
            ./hardware-configuration.nix
         ];
      };
    };
}
