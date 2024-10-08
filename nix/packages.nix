{pkgs, inputs, ...}: {
  environment.systemPackages = with pkgs; [
    hplipWithPlugin
    neovim
    discord
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
    (python3.withPackages(ps: with ps; [ pwntools pycryptodome jedi-language-server ipython z3-solver ]))
    wget
    wl-clipboard
    xclip
    trash-cli
    unzip
    zip
    gimp
    virtualbox
    gdk-pixbuf
    xournalpp
    busybox
    #ghidra-bin
  	spotify
    vscode
  	man-pages
  	man-pages-posix
	  # Oh god it's TeXLive my worst enemy (The storage kills)
		#texliveFull
    (vscode-with-extensions.override { 
      vscodeExtensions = with vscode-extensions; [
        vscjava.vscode-java-pack
        ms-python.python
        ms-vscode-remote.remote-ssh
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    ];
    })

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
    oraclejdk8
    input-remapper
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    #podman-compose # start group of containers for dev

    # An FHS shortcut to help us from the interwebs
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
          pkgs.buildFHSUserEnv (base // {
          name = "fhs";
          targetPkgs = pkgs: (
            # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
            # lacking many basic packages needed by most software.
            # Therefore, we need to add them manually.
            #
            # pkgs.appimageTools provides basic packages required by most software.
            (base.targetPkgs pkgs) ++ [
              pkgs.pkg-config
              pkgs.ncurses
              # Feel free to add more packages here if needed.
            ]
          );
          profile = "export FHS=1";
          runScript = "bash";
          extraOutputsToInstall = ["dev"];
        }))
  ] ++ 
  [
    #pkgs.cachix
  ];
}
