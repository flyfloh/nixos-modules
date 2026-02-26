{
  description = "NixOS Modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: {

    nixosModules = {
      cattle = import modules/cattle.nix;
      flavours = import modules/flavours.nix;
    };
  };

}


