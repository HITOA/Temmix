{
  description = "A thmeing packaegs.";

  inputs = {
    lain-src = {
      url = "github:HITOA/Lain";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, lain-src, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { 
      inherit system;
      overlays = [
        (final: prev: lain = (pkgs.callPackage ./lain.nix { pkgs = prev; inherit system lain-src; }))
      ];
    };
  in
  {
    nixosModules.temmix = import ./temmix/nixos self.homeManagerModules.temmix;
    nixosModules.default = self.nixosModules.temmix;

    homeManagerModules.temmix = import ./temmix/hm;
    homeManagerModules.default = self.homeManagerModules.temmix;

    packages."${system}".default = pkgs.lain;
  };
}