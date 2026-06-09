{pkgs, lib, ... }:
let
  luksCryptenroller = pkgs.writeTextFile {
    name = "luksCryptenroller";
    destination = "/bin/luksCryptenroller";
    executable = true;

    text = let
      luksDevice01 = "NIXLUKS";
    in ''
      sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+7 /dev/disk/by-label/${luksDevice01}
    '';
  };
in
{
  environment.systemPackages = [
    luksCryptenroller
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
    # Needed to use the TPM2 chip with `systemd-cryptenroll`
    pkgs.tpm2-tss
  ];

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}

