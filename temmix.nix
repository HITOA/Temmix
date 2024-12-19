{ lain-src } : { lib, config, pkgs, system, ... }: {
    options.temmix = {
        enable = lib.mkEnableOption "Enable temmix.";
    };

    config = 
    let
        lain = pkgs.callPackage ./lain.nix { inherit pkgs system lain-src; };
        setwall = pkgs.writeShellScriptBin "setwall" ''
            if [ "$1" == "" ]; then
                echo "Missing filename."
                exit
            fi

            ${lain} -i $1
        '';
    in
    lib.mkIf config.temmix.enable 
    {
        environment.systemPackages = [ setwall ];
    };
}