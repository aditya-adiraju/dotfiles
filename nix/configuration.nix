# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Nix Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
	
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Enable Hyprland <
  services.xserver.displayManager.gdm.wayland = true;  
  
  programs.hyprland = {    
      enable = true;    
      xwayland.enable = true;    
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; 

  # Configurekeymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Install a bunch of fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    powerline-fonts
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable flatpak repos
  services.flatpak.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aditya = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Aditya Adiraju";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      discord
      firefox
      ghidra
      neofetch
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    logisim-evolution
    htop
    git
    gh
    google-chrome
    tilix
    gnome3.gnome-tweaks
    cowsay
    oh-my-zsh
    python3
    nix-ld
    sublime4
    wget
    wl-clipboard
    unzip
    zip
    zsh
    tmux
    kitty
    obsidian
    gimp
    gdk-pixbuf
    gdb
    pwndbg



    (neovim.override {
        vimAlias = true;
        viAlias = true;
        configure = {
          customRC = ''
            set shiftwidth=2 expandtab
            set termguicolors
            colorscheme monokai_pro
            set smarttab
            set number
            set clipboard+=unnamedplus
            let g:airline_theme='deus'
            let g:airline_powerline_fonts = 1 
            highlight Normal ctermbg=NONE guibg=NONE


            inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
            inoremap <silent><expr> <cr> "\<c-g>u\<CR>"
          '';
          packages.myPlugins = with vimPlugins; {
          start = [
            papercolor-theme
            vim-monokai-pro
            vim-airline-themes
            vim-airline
            nvim-lspconfig
            chad
            coc-nvim
            coc-clangd
            vim-multiple-cursors
          ];
          opt = [];
    	};
      };
    })

    vscode
    (vscode-with-extensions.override { 
      # When the extension is already available in the default extensions set.
      vscodeExtensions = with vscode-extensions; [
        ms-vscode.cpptools
        ms-vscode-remote.remote-ssh
	ms-python.vscode-pylance
	ms-python.python
      ]
      # Concise version from the vscode market place when not available in the default set.
      ++ vscode-utils.extensionsFromVscodeMarketplace [
	{
	  name = "code-runner";
	  publisher = "formulahendry";
	  version = "0.6.33";
	  sha256 = "166ia73vrcl5c9hm4q1a73qdn56m0jc7flfsk5p5q41na9f10lb0";
	}
      ];
    })
    # build tools
    # Things that should be migrated to shell.nix or flake.nix
    gnumake
    stdenv
    clang_16
    clang-tools_16
    libgcc
    nodePackages_latest.nodejs
    sageWithDoc
    jupyter

  ];

  nixpkgs.config.permittedInsecurePackages = [
       "openssl-1.1.1w"
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

 users.defaultUserShell = pkgs.zsh;

 programs.zsh = {
    enable = true;
    shellAliases = {
      ll="ls -la";
    };
    enableCompletion = true;
    autosuggestions.enable = true;
    promptInit = "";
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "lukerandall";
    };

  };

  programs.nix-ld.enable = true;
  
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    zlib
    nss
    openssl
    curl
    expat
    libcxx
    libcxxabi
    libcxxStdenv
  ];


  # default editor
  environment.variables.EDITOR = "nvim";
  # List services that you want to enable:
  programs.git.config = {
    user.email = "adiraju@student.ubc.ca";
    user.name = "aditya-adiraju";
  };
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
