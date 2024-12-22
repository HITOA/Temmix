homeManagerModule: { lib, config, pkgs, ... }: {
    imports = [ (import ./hm-integration.nix homeManagerModule) ];

    options.temmix = {
        enable = lib.mkOption {
            type = lib.types.bool;
            description = "Enable temmix for nixos.";
            default = false;
        };
    };

    config = lib.mkIf config.temmix.enable 
    {
        
    };
}