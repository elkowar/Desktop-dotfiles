{ config, lib, pkgs, ... }:
let
  cfg = config.elkowar.desktop;
in
{
  options.elkowar.desktop = {
    enable = lib.mkEnableOption "Desktop configuration enabled";
  };

  imports = [ ./desktop ];



  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (scr.override { extraPackages = [ rofi ]; })
      mmutils
      liquidctl
      bashtop
      cool-retro-term
      gromit-mpx
      dragon-drop
      polybarFull
      discord
      my-st
      #hyper-haskell
    ];


    elkowar.desktop = {
      gtk.enable = true;
    };

    elkowar.programs = {
      alacritty.enable = true;
      rofi.enable = true;
      firefox.enable = false;
    };

    programs = {
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

      feh = {
        enable = true;
        keybindings = { zoom_in = "plus"; zoom_out = "minus"; };
      };

    };

    services = {
      mpd = {
        enable = true;
        musicDirectory = "/home/leon/Downloads/music";
      };
      udiskie.enable = true;
    };
  };
}
