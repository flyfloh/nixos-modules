{ config, lib, pkgs, ... }:

{
  imports = [
    ./gaming.nix
    ./gnome.nix
    ./hetzner-vm.nix
    ./vaapi.nix
  ];
}
