lain: { lib, config, pkgs, ... }: {
    imports = [ ../../modules ];

    options.temmix = {
        enable = lib.mkOption {
            type = lib.types.bool;
            description = "Enable temmix for home-manager.";
            default = false;
        };
        templates = lib.mkOption {
            type = lib.types.listOf lib.types.submodule {
                options = {
                    input = lib.mkOption { type = lib.types.string; };
                    output = lib.mkOption { type = lib.types.string; };
                };
            };
            default = [];
        };
        wallpaperCmd = lib.mkOption {
            type = lib.types.string;
            default = "";
        };
    };

    config = 
    let
        argsTemplates = builtins.map (value: "-t ${value.input} ${value.output}") config.temmix.templates;
        setwall = pkgs.writeShellScriptBin "setwall" ''
            if [ "$1" == "" ]; then
                echo "Missing filename."
                exit
            fi

            ${config.temmix.wallpaperCmd}

            ${lain}/bin/lain -i $@ ${builtins.concatStringsSep " " argsTemplates}
        '';
    in
    lib.mkIf config.temmix.enable 
    {
        home.packages = [ setwall ];
    };
}