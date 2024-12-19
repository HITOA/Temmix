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
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    nixosModules.temmix = import ./temmix.nix;
    nixosModules.default = self.nixosModules.temmix;
  };
}