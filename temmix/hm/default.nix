pkgs: { lib, config, ... }: {
    imports = [ ../../modules/hm.nix ./opacity.nix ];

    options.temmix = {
        enable = lib.mkOption {
            type = lib.types.bool;
            description = "Enable temmix for home-manager.";
            default = false;
        };
        templates = lib.mkOption {
            type = lib.types.listOf (lib.types.submodule {
                options = {
                    input = lib.mkOption { type = lib.types.path; };
                    output = lib.mkOption { type = lib.types.path; };
                };
            });
            default = [];
        };
        commands = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
        };
        cacheFile = lib.mkOption {
            type = lib.types.path;
            default = config.xdg.cacheHome + "/temmix";
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
            
            ${pkgs.lain}/bin/lain -i $@ ${builtins.concatStringsSep " " argsTemplates}

            ${builtins.concatStringsSep "\n" config.temmix.commands}
        '';
    in
    lib.mkIf config.temmix.enable 
    {
        home.file."${config.temmix.cacheFile}/.keep" = {
            enable = true;
            executable = false;
            text = "";
        };
        home.packages = [ setwall ];
    };
}