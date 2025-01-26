{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings = {
      sandbox = true;
      trusted-users = [ "root" "@wheel" ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  networking.useDHCP = false;

  programs = {
    command-not-found.enable = true;
    vim = {
      enable = true;
      defaultEditor = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    ripgrep
    tmux
    vim
    wget
  ];
}

