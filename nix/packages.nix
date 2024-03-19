{pkgs, inputs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    zsh
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
    gnome3.gnome-tweaks
    gnome.gnome-themes-extra
    (python3.withPackages(ps: with ps; [ pillow pwntools pycryptodome jedi-language-server ipython z3-solver ]))
    wget
    wl-clipboard
    xclip
    trash-cli
    unzip
    zip
    gimp
    gnuradio
    virtualbox
    gdk-pixbuf
    xournalpp
    busybox
	  ripgrep
    ghidra-bin
  	spotify
    vscode
    zathura
  	man-pages
  	man-pages-posix
	  # Oh god it's TeXLive my worst enemy (The storage kills)
	  texliveFull
    (vscode-with-extensions.override { 
      vscodeExtensions = with vscode-extensions; [
	      ms-python.python
      ];
    })

    # build tools
    # Things that should be migrated to shell.nix or flake.nix
	  docker
	  docker-compose
    gnumake
    # stdenv
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
	  

    darling


    sage
    osu-lazer-bin
    jetbrains.pycharm-community-bin
    poetry
  ] ++ 
  [
    pkgs.cachix
  ];
}
