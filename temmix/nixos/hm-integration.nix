homeManagerModule: { lib, config, pkgs, options, ... }: 
let
    paths = { osConfig, ... }: builtins.map (value: ["temmix"] ++ value) (lib.collect lib.isList (lib.mapAttrsRecursive (key: value: key) osConfig.temmix));
    copyModule = builtins.map (
        path:
        { config, osConfig, ... }:
        lib.setAttrByPath path (lib.mkDefault (lib.getAttrFromPath path osConfig))
    ) paths;
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
        home-manager.sharedModules = [ homeManagerModule ] ++ copyModule;
    });
}