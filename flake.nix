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
    lain = pkgs.callPackage ./lain.nix { inherit pkgs system lain-src; };
  in
  {
    nixosModules.temmix = import ./nixos.nix lain self.homeManagerModules.temmix;
    nixosModules.default = self.nixosModules.temmix;

    homeManagerModules.temmix = { config, ... }: import ./hm.nix config;
    homeManagerModules.default = self.homeManagerModules.temmix;
  };
}