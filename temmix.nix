{ lib, config, ... }: {
    options.temmix = {
        enable = lib.mkEnableOption "Enable temmix.";
    };

    config = lib.mkIf config.temmix.enable 
    let
        setwall = pkgs.writeShellScriptBin "setwall" ''
            if [ "$1" == "" ]; then
                exit
            fi

            echo pute
        '';
    in
    {
        home.packages = [ setwall ];
    };
}