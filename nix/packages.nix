{pkgs, inputs, ...}: {
  environment.systemPackages = with pkgs; [
    nomachine-client
    rustc
    cargo
    pinentry-curses
    gnupg
    hplipWithPlugin
    obsidian
    musescore
    neovim
    vesktop
    zsh
    file
    oh-my-zsh
    htop
    git
    gh
    gdb
    tilix
    tmux
    nix-ld
    google-chrome
	  zoom-us
    gnome-tweaks
    gnome-themes-extra
    (python3.withPackages(ps: with ps; [ requests tqdm numpy gmpy2 pwntools pycryptodome jedi-language-server ipython z3-solver ]))
    wget
    wl-clipboard
    xclip
    trash-cli
    unzip
    zip
    gimp
    gdk-pixbuf
    xournalpp
    busybox
  	spotify
    vscode-fhs # please work please make my life easy
  	man-pages
  	man-pages-posix

    # build tools
    # Things that should be migrated to shell.nix or flake.nix
	  docker
	  docker-compose
    gnumake
    # stdenv
    stdenv.cc.cc.lib
    clang_16
    clang-tools_16
  	gcc
    nodePackages.nodejs
    nodePackages.typescript-language-server
    nodePackages.prettier
    nodePackages.http-server
    nodePackages.live-server
    nodePackages.eslint
    nodePackages."@tailwindcss/language-server"
    nodePackages."@angular/cli"
    slack
    obsidian
    sage
    fastfetch
    gap-full
    pari
    #osu-lazer-bin
    websocat
    openjdk
    input-remapper
    dive # look into docker image layers
    docker-compose # start group of containers for dev
    go
    kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    kdePackages.kcolorchooser # A small utility to select a color
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdiff3 # Compares and merges 2 or 3 files or directories
    kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
    kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
    hardinfo2 # System information and benchmarks for Linux systems
    haruna # Open source video player built with Qt/QML and libmpv
    wayland-utils # Wayland utilities
  ] ++ 
  [
    #pkgs.cachix
  ];
}
