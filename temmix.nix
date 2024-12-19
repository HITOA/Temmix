{ ... }: {
    options.temmix = {
        enable = lib.mkEnableOption "Enable temmix.";
    };

    config = lib.mkIf config.temmix.enable {
        setwall = pkgs.writeShellScriptBin "setwall" ''
            if [ "$1" == "" ]; then
                exit
            fi

            echo pute
        '';

        home.packages = [ setwall ];
    };
};