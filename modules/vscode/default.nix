{ lib, config, ... } : {
    options.temmix.vscode = {
        enable = lib.mkOption {
            type = types.bool;
            description = "Enable theming for VSCode.";
            default = programs.vscode.enable;
        };
    };

    config = lib.mkIf config.temmix.vscode.enable 
    {
        
    };
}