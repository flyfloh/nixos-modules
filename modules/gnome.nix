{ config, lib, pkgs, ... }:

let
  cfg = config.flavours.gnome;

in {
  options.flavours.gnome = {
    enable = lib.mkEnableOption "Enable Gnome";
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
    networking.wireless.enable = false;

    services.libinput.enable = true;
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "us";
        variant = "dvorak";
        options = "eurosign:e";
      };
    };

    environment.systemPackages = with pkgs; [
      direnv
      element-desktop
      firefox
      gnome-terminal
      nextcloud-client
      nix-direnv
      signal-desktop
      thunderbird
    ];
    environment.pathsToLink = [
      "/share/nix-direnv"
    ];

    nix.extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    services.lorri.enable = true;

    services.fwupd.enable = true;
    services.hardware.bolt.enable = true;

    services.printing.enable = true;

    # Find the network printer
    services.avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };
}
