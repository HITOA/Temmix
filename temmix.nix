lain : { lib, config, pkgs, ... }: {
    options.temmix = {
        enable = lib.mkEnableOption "Enable temmix.";
        templates = lib.mkOption {
            type = lib.types.listOf (lib.types.submodule {
                input = lib.mkOptions {
                    type = lib.types.path;
                };
                output = lib.mkOptions {
                    type = lib.types.path;
                };
            });
        };
        wallpaperCmd = lib.mkOption {
            type = lib.types.string;
        }
    };

    config = 
    let
        argsTemplates = builtins.map (value: "-t ${value.input} ${value.output}") config.temmix.templates
        setwall = pkgs.writeShellScriptBin "setwall" ''
            if [ "$1" == "" ]; then
                echo "Missing filename."
                exit
            fi

            shift 1
            ${lain}/bin/lain -i $@ ${builtins.concatStringsSep " " argsTemplates}

            ${config.temmix.wallpaperCmd}
        '';
    in
    lib.mkIf config.temmix.enable 
    {
        environment.systemPackages = [ setwall ];
    };
}