{ config, lib, ... }:

let
  cfg = config.homelab.system;
  dm = if cfg.desktopType == "kde" then {
    displayManager.sddm.enable    = true;
    desktopManager.plasma5.enable = true;
  } else {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

in {

  options.homelab.system = {
    isDesktop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Set to true when this is a desktop, otherwise system will be treated
        as server.
      '';
    };

    desktopType = lib.mkOption {
      type = lib.types.str;
      default = "kde";
      description = "Set Desktop to KDE or Gnome";
    };
  };

  config = lib.mkIf cfg.isDesktop {

    networking.networkmanager.enable = true;
    networking.wireless.enable = false;

    sound.enable = true;
    hardware.pulseaudio.enable = true;

    services.libinput.enable = true;
    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "dvorak";
        options = "eurosign:e";
      };
    } // dm;
  };
}

