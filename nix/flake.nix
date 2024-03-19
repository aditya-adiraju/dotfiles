{
  description = "The jankiest NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-gaming = {
      url = "github:aditya-adiraju/nix-gaming";
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
                  ];
    };
  };
}
