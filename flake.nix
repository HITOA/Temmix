{
  description = "A thmeing packaegs.";

  inputs = {
    /*home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };*/

    lain-src = {
      url = "github:HITOA/Lain";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs @ { self, nixpkgs, lain-src, ... }:
  let
    pkgs = import nixpkgs;
    lain = pkgs.callPackage ./lain.nix lain-src;
  in
  {
    nixosModules.temmix = import ./temmix.nix lain;
    nixosModules.default = self.nixosModules.temmix;
  };
}