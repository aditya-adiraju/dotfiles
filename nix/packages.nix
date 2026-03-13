{pkgs, inputs, ...}: {
  environment.systemPackages = with pkgs; [

    # Language-specific tools
    (python3.withPackages(ps: with ps; [ requests tqdm numpy gmpy2 pwntools pycryptodome ipython z3-solver pandas ]))
    cargo
    clang-tools
    clang_multi
    gap-full
    gcc
    ghc
    gnumake
    go
    haskell-language-server
    nix-ld
    nodePackages.eslint
    nodePackages.http-server
    nodePackages.nodejs
    nodePackages.prettier
    nodePackages.typescript-language-server
    openjdk
    pari
    patchelf
    rustc
    stdenv.cc.cc.lib
    typst # uwu
    vscode-fhs # please work please make my life easy
    pinentry-curses
    gnupg


    # User applications
    firefox
    gimp
    google-chrome
    slack
    spotify
    xournalpp
    zoom-us


    # Basic CLI tools/terminal
    busybox
    docker
    docker-compose
    fastfetch
    file
    gdb
    gef
    git
    htop
    man-pages
    man-pages-posix
    neovim
    networkmanager-openvpn
    oh-my-zsh
    openvpn
    ripgrep
    tmux
    trash-cli
    unzip
    websocat
    wezterm
    wget
    xclip
    zip
    zsh

    # DE Helpers
    gnome-themes-extra
    gnome-tweaks
    wl-clipboard
    wayland-utils

    # Special tools
    hplipWithPlugin

  ] ++ 
  [
    #pkgs.cachix
  ];
}
