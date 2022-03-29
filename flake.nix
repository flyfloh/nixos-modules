{
  description = "NixOS Modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };

  outputs = { self, nixpkgs }: {

    nixosModules = {
      desktop = import modules/desktop.nix;
    };
  };

}


