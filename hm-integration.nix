homeManagerModule: { lib, config, ... }: {
    options.temmix.home-manager = {
        autoImport = lib.mkOption {
            type = lib.types.bool;
            default = true;
        };
    };

    config = lib.mkIf config.temmix.home-manager.autoImport {
        home-manager.sharedModules = [ homeManagerModule ];
    };
} 