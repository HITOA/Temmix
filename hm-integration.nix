homeManagerModule: { lib, config, options, ... }: 
{
    options.temmix.home-manager = {
        autoImport = lib.mkOption {
            type = lib.types.bool;
            default = true;
        };
    };

    config = 
    lib.optionalAttrs (options ? home-manager)
    (lib.mkIf config.temmix.home-manager.autoImport {
        home-manager.sharedModules = [ (homeManagerModule config) ];
    });
} 