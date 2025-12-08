{ config, lib, pkgs, ... }:

let
  cfg = config.flavours.vaapi;

in {

  options.flavours.vaapi = {
    enable = lib.mkEnableOption "Enable Intel VAAPI";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    };
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        libva-vdpau-driver
        libvdpau-va-gl
        intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      ];
    };
  };
}
