{ config, pkgs, lib, ... }:

{
  nix = {
    extraOptions = ''
      connect-timeout = 5
      log-lines = 25
      min-free = 128000000
      max-free = 1000000000

      fallback = true
      warn-dirty = false
      auto-optimise-store = true
    '';
  };
}
