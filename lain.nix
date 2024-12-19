{ lain-src } : { pkgs, system, ... }:
pkgs.stdenv.mkDerivation {
    name = "lain";
    inherit system;
    src = lain-src;
    buildPhase = ''
        gcc src/image.cpp src/main.cpp src/quantizer.cpp src/theme.cpp -o lain -lstdc++ -lm -std=gnu++20 -O3
    '';
    installPhase = ''
        mkdir -p $out/bin
        cp lain $out/bin/lain
    '';
}