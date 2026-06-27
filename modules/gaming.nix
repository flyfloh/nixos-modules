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
      enable = true;
      enable32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };

    programs.gamemode.enable = true;
    programs.steam.enable = true;

    services.pulseaudio.support32Bit = true;

    environment.systemPackages = with pkgs; [
      (heroic.override {
        extraPkgs = pkgs': with pkgs'; [
          gamemode
        ];
      })

      heroic
      wineWow64Packages.stable
    ];
    services.joycond.enable = true;
  };
}

