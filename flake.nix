{
  description = "NixOS Modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };

  outputs = { self, nixpkgs }: {

    nixosModules = {
      cattle = import modules/cattle.nix;
      desktop = import modules/desktop.nix;
    };
  };

}


