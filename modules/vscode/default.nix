{ lib, config, ... } : {
    options.temmix.vscode = {
        enable = lib.mkOption {
            type = lib.types.bool;
            description = "Enable theming for VSCode.";
            default = config.programs.vscode.enable;
        };
    };

    config = lib.mkIf config.temmix.vscode.enable 
    {

    };
}