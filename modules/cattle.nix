{ config, lib, ... }:

let
  cfg = config.homelab.system;

in
{
  options.homelab.system.isCattle = lib.mkOption {
    description = "Enables a system without the intention of a user login";
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf cfg.isCattle {
    documentation.enable = false;
    users.mutableUsers = lib.mkDefault false;
  };
}
