homeManagerModule: { lib, config, pkgs, options, ... }: 
let
    copyModule = builtins.map (
        path:
        { config, osConfig, ... }:
        lib.mkIf false (lib.setAttrByPath path (lib.mkDefault (lib.getAttrFromPath path osConfig)))
    ) (builtins.map (value: ["temmix"] ++ value) (lib.collect lib.isList (lib.mapAttrsRecursive (key: value: key) config.temmix)));
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