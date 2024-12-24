homeManagerModule: { lib, config, pkgs, options, ... }: 
let
    copyModule = { lib, osConfig, ... }: {
        config = {
            temmix = lib.mkMerge [ temmix osConfig.temmix ];
        };
    };
in
{
    options.temmix.hm = {
        autoImport = lib.mkOption {
            type = lib.types.bool;
            description = "Wether to import temmix automatically for every Home Manager user.";
            default = true;
        };
    };

    config = 
    lib.optionalAttrs (options ? home-manager)
    (lib.mkIf config.temmix.hm.autoImport
    {
        home-manager.sharedModules = [ homeManagerModule copyModule ];
    });
}