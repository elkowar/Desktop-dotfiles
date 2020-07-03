# https://nixos.wiki/wiki/Wrappers_vs._Dotfiles
# https://nixos.org/nixos/manual/index.html#sec-writing-modules

# do this to change to fork
# nix-channel --add https://github.com/ElKowar/home-manager/archive/alacritty-package-option.tar.gz home-manager
# nix-channel --update
# nix-env -u home-manager

{ config, pkgs, ... }:
let
  elkowar_local = import ./local/default.nix {};
  myConf = import ./myConfig.nix;
in
{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };


  home.packages = [
    elkowar_local.bashtop
    pkgs.htop
    pkgs.direnv
    pkgs.rnix-lsp
    pkgs.nix-prefetch-git
    pkgs.gtop
    pkgs.simplescreenrecorder
    pkgs.bat
    pkgs.websocat
    #pkgs.timg
  ];


  programs = {
    home-manager.enable = true;
    alacritty = import ./config/alacritty.nix { inherit pkgs; inherit myConf; }; # <- https://github.com/guibou/nixGL
    #firefox = import ./config/firefox.nix;
    feh = import ./config/feh.nix;
    zsh = import ./config/zsh.nix { inherit pkgs; inherit myConf; };
    lsd = {
      enable = true;
      enableAliases = true;
    };

    mpv = {
      enable = true;
      bindings = {
        WHEEL_UP = "add volume 5";
        WHEEL_DOWN = "add volume -5";
        WHEEL_LEFT = "seek -3";
        WHEEL_RIGHT = "seek 3";
        h = "seek -3";
        l = "seek 3";
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "rg --files";
      fileWidgetCommand = "fd --type f";
      changeDirWidgetCommand = "rg --files --null | xargs -0 dirname | sort -u";
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      #enableNixDirenvIntegration = true;
    };
  };

  home.username = "leon";
  home.homeDirectory = "/home/leon";

  home.stateVersion = "20.09";
}