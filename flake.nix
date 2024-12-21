{
  description = "A thmeing packaegs.";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lain-src = {
      url = "github:HITOA/Lain";
      flake = false;
    };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, lain-src, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    lain = pkgs.callPackage ./lain.nix { inherit pkgs system lain-src; };
    setwall = {
      name = "setwall";
      builder = "${pkgs.bash}/bin/bash";
      args = [ ./setwall-builder.sh ];
      inherit system;
      inherit (pkgs) coreutils;
    };
  in
  {
    nixosModules.temmix = import ./temmix/nixos setwall;
    nixosModules.default = self.nixosModules.temmix;

    homeManagerModules.temmix = import ./temmix/hm;
    homeManagerModules.default = self.homeManagerModules.temmix;

    packages."${system}".default = builtins.derivation setwall;
  };
}