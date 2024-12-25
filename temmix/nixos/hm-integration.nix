homeManagerModule: { lib, config, pkgs, options, ... }: 
let
    copyModules = builtins.map (
        path:
        { config, osConfig, ... }:
        lib.setAttrByPath path (lib.mkDefault (lib.getAttrFromPath path osConfig))
    ) [
        [ "temmix" "enable" ]
        [ "temmix" "targets" "gtk" "enable" ]
    ];
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
        home-manager.sharedModules = [ homeManagerModule ] ++ copyModules;
    });
}