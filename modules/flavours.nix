{ config, lib, pkgs, ... }:

{
  imports = [
    ./gaming.nix
    ./vaapi.nix
  ];
}
