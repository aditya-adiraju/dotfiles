# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  
  # import files
  # Bootloader.
  boot.supportedFilesystems = [ "btrfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.allowBroken = true;
  nix.package = pkgs.lix;

  hardware.opentabletdriver.enable = true;
  # Enable Nix Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto optimize hardlinks
  nix.settings.auto-optimise-store = true;

  networking.hostId = "0e86aea3";
  networking.hostName = "nixos"; # Define your hostname.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";

  services.ollama.enable = true;
  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Hyprland
  #programs.hyprland.enable = true;
  # services.desktopManager.plasma6.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # docker support
  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--insecure-registry us-west1-docker.pkg.dev";
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  # VirtualBox Support
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; 

  # Configurekeymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;
  services.printing.drivers = [pkgs.hplipWithPlugin];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  
  # Enable sound with pipewire.
  #sound.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    context.properties = {
      default.clock.rate = 48000;
      default.clock.quantum = 32;
      default.clock.min-quantum = 32;
      default.clock.max-quantum = 32;
    };
  };
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable flatpak repos
  services.flatpak.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aditya = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Aditya Adiraju";
    extraGroups = [ "docker" "networkmanager" "wheel" "user-with-access-to-virtualbox" "adbusers" "vboxusers" ];
    packages = with pkgs; [
      firefox
    ];
  };

  users.users."0day" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "0 day";
    extraGroups = [ ];
    packages = with pkgs; [
      firefox
    ];
  };
  # Enable ZSH
  programs.zsh.enable = true;
  programs.zsh.vteIntegration = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
       "openssl-1.1.1w"
      "libsoup-2.74.3"
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

 users.defaultUserShell = pkgs.zsh;

  # I love man pages
  documentation.dev.enable = true;


  
  # Automatically creates a loader in /lib/* to avoid patching stuff
  # To disable it temporarily use
  # unset NIX_LD
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # List by default
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
      
      # My own additions
      xorg.libXcomposite
      xorg.libXtst
      xorg.libXrandr
      xorg.libXext
      xorg.libX11
      xorg.libXfixes
      libGL
      libva
      pipewire
      xorg.libxcb
      xorg.libXdamage
      xorg.libxshmfence
      xorg.libXxf86vm
      libelf

      # Required
      glib
      gtk2

      # Inspired by steam
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/st/steam/package.nix#L36-L85
      networkmanager      
      vulkan-loader
      libgbm
      libdrm
      libxcrypt
      coreutils
      pciutils
      zenity
      # glibc_multi.bin # Seems to cause issue in ARM
      
      # # Without these it silently fails
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libXi
      xorg.libSM
      xorg.libICE
      gnome2.GConf
      nspr
      nss
      cups
      libcap
      SDL2
      libusb1
      dbus-glib
      ffmpeg
      # Only libraries are needed from those two
      libudev0-shim
      
      # needed to run unity
      gtk3
      icu
      libnotify
      gsettings-desktop-schemas
      # https://github.com/NixOS/nixpkgs/issues/72282
      # https://github.com/NixOS/nixpkgs/blob/2e87260fafdd3d18aa1719246fd704b35e55b0f2/pkgs/applications/misc/joplin-desktop/default.nix#L16
      # log in /home/leo/.config/unity3d/Editor.log
      # it will segfault when opening files if you don’t do:
      # export XDG_DATA_DIRS=/nix/store/0nfsywbk0qml4faa7sk3sdfmbd85b7ra-gsettings-desktop-schemas-43.0/share/gsettings-schemas/gsettings-desktop-schemas-43.0:/nix/store/rkscn1raa3x850zq7jp9q3j5ghcf6zi2-gtk+3-3.24.35/share/gsettings-schemas/gtk+3-3.24.35/:$XDG_DATA_DIRS
      # other issue: (Unity:377230): GLib-GIO-CRITICAL **: 21:09:04.706: g_dbus_proxy_call_sync_internal: assertion 'G_IS_DBUS_PROXY (proxy)' failed
      
      # Verified games requirements
      xorg.libXt
      xorg.libXmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew110
      libidn
      tbb
      
      # Other things from runtime
      flac
      freeglut
      libjpeg
      libpng
      libpng12
      libsamplerate
      libmikmod
      libtheora
      libtiff
      pixman
      speex
      SDL_image
      SDL_ttf
      SDL_mixer
      SDL2_ttf
      SDL2_mixer
      libappindicator-gtk2
      libdbusmenu-gtk2
      libindicator-gtk2
      libcaca
      libcanberra
      libgcrypt
      libvpx
      librsvg
      xorg.libXft
      libvdpau
      # ...
      # Some more libraries that I needed to run programs
      pango
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype
      dbus
      alsa-lib
      expat
      # for blender
      libxkbcommon

      libxcrypt-legacy # For natron
      libGLU # For natron

      # Appimages need fuse, e.g. https://musescore.org/fr/download/musescore-x86_64.AppImage
      fuse
      e2fsprogs
    ];
  };  

  # default editor
  environment.variables.EDITOR = "nvim";
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };


  # List services that you want to enable:
  programs.git.config = {
    user.email = "adiraju@student.ubc.ca";
    user.name = "aditya-adiraju";
  };
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  # maybe I should try sway 

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.waybar.enable = true;

  # Open ports in the firewall.
   #networking.firewall.allowedTCPPorts = [ 4000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = true;
  networking.firewall.allowedTCPPortRanges = [
    { from = 4000; to = 5007; }
    { from = 8000; to = 8010; }
  ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
