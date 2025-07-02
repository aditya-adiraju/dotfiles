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
    zed-editor
    neovim
    vesktop
    zsh
    file
    oh-my-zsh
    htop
    git
    gh
    gdb
    pwndbg
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
    #ghidra-bin
  	spotify
    vscode-fhs # please work please make my life easy
  	man-pages
  	man-pages-posix
	  # Oh god it's TeXLive my worst enemy (The storage kills)
		#texliveFull

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
    gopls
  ] ++ 
  [
    #pkgs.cachix
  ];
}
