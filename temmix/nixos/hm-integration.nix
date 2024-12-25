homeManagerModule: { lib, config, pkgs, options, ... }: 
{
    options.temmix.hm = {
        autoImport = lib.mkOption {
            type = lib.types.bool;
            description = "Wether to import temmix automatically for every Home Manager user.";
            default = true;
        };
        additionalPaths = lib.mkOption {
            type = lib.types.listOf (lib.types.listOf lib.types.str);
            default = [];
        };
    };

    config = 
    let
        copyModules = builtins.map (
            path:
            { config, osConfig, ... }:
            lib.setAttrByPath path (lib.mkDefault (lib.getAttrFromPath path osConfig))
        ) [
            ["temmix" "enable"]
        ] ++ config.additionalPaths;
    in
    lib.optionalAttrs (options ? home-manager)
    (lib.mkIf config.temmix.hm.autoImport
    {
        home-manager.sharedModules = [ homeManagerModule ] ++ copyModules;
    });
}