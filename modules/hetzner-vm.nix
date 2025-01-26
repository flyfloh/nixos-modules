{ config, lib, pkgs, ... }:

let
  cfg = config.flavours.hetzner-vm;

in {
  options.flavours.hetzner-vm = {
    enable = lib.mkEnableOption "Enable Config for Hetzner VMs";
  };

  config = lib.mkIf cfg.enable {
    #imports = [ "${pkgs}/nixos/modules/profiles/qemu-guest.nix" ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";

    services.openssh = {
      enable = true;
      openFirewall = true;
      settings.PermitRootLogin = "no";
    };
  };
}
