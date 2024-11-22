{ config, lib, pkgs, ... }:

let
  cfg = config.flavours.gaming;

in {

  options.flavours.gaming = {
    enable = lib.mkEnableOption "Enable Gaming Configuration";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    hardware.graphics = {
      enable32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
    hardware.pulseaudio.support32Bit = true;

    environment.systemPackages = with pkgs; [
      #steam-run-native
      steam
      wineWowPackages.stable
      #(winetricks.override { wine = wineWowPackages.stable; })
    ];
    services.joycond.enable = true;
  };
}

