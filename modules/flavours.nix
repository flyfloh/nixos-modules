{ config, lib, pkgs, ... }:

{
  imports = [
    ./gaming.nix
    ./gnome.nix
    ./vaapi.nix
  ];
}
