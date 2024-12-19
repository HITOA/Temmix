lain : { lib, config, pkgs, ... }: {
    options.temmix = {
        enable = lib.mkEnableOption "Enable temmix.";
    };

    config = 
    let
        setwall = pkgs.writeShellScriptBin "setwall" ''
            if [ "$1" == "" ]; then
                echo "Missing filename."
                exit
            fi

            ${lain}/bin/lain -i $1
        '';
    in
    lib.mkIf config.temmix.enable 
    {
        environment.systemPackages = [ setwall ];
    };
}