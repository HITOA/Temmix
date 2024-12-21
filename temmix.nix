lain : { lib, config, pkgs, ... }: {
    options.temmix = {
        enable = lib.mkEnableOption "Enable temmix.";
        wallpaperCmd = lib.mkOption {
            type = lib.types.string;
            default = "";
        };
    };

    config = 
    let
        argsTemplates = builtins.map (value: "-t ${value.input} ${value.output}") config.temmix.templates;
        setwall = pkgs.writeShellScriptBin "setwall" ''
            if [ $# <= 1 ]; then
                echo "Missing filename."
                exit
            fi

            shift
            ${lain}/bin/lain -i $@

            ${config.temmix.wallpaperCmd}
        '';
    in
    lib.mkIf config.temmix.enable 
    {
        environment.systemPackages = [ setwall ];
    };
}