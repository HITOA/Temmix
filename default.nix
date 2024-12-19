{ pkgs, system, lain-src, ... }:
pkgs.stdenv.mkDerivation {
    name = "lain";
    inherit system;
    src = lain-src;
    buildPhase = ''
        mkdir -p $out/bin
        gcc src/image.cpp src/main.cpp src/quantizer.cpp src/theme.cpp -o $out/bin/lain -lstdc++ -lm -std=gnu++20 -O3
    '';
}