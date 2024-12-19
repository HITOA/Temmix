{ lib, config, ... }: {
    options.temmix = {
        enable = lib.mkEnableOption "Enable temmix.";
    };

    config = 
    let
        setwall = pkgs.writeShellScriptBin "setwall" ''
            if [ "$1" == "" ]; then
                exit
            fi

            echo pute
        '';
    in
    lib.mkIf config.temmix.enable 
    {
        home.packages = [ setwall ];
    };
}