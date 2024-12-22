{ lib, config, pkgs, ... } : 
let
    colorThemeDataPath = "/temmix/vscode/temmix-vscode-color-theme.json";
    colorThemePath = config.xdg.dataHome + colorThemeDataPath;
    themeExtension = pkgs.runCommandLocal "temmix-vscode" {
        vscodeExtUniqueId = "temmix.temmix";
        vscodeExtPublisher = "temmix";
        version = "0.0.0";
    } ''
        mkdir -p "$out/share/vscode/extensions/$vscodeExtUniqueId/themes"
        ln -s ${./temmix-vscode/themes/Temmix-color-theme.json} "$out/share/vscode/extensions/$vscodeExtUniqueId/themes/Temmix-color-theme.json"
        ln -s ${colorThemePath} "$out/share/vscode/extensions/$vscodeExtUniqueId/package.json"
    '';
in
{
    options.temmix.vscode = {
        enable = lib.mkOption {
            type = lib.types.bool;
            description = "Enable theming for VSCode.";
            default = config.programs.vscode.enable;
        };
    };

    config = lib.mkIf (config.temmix.enable && config.temmix.vscode.enable)
    {
        xdg.dataFile."${colorThemeDataPath}" = {
            enable = true;
            executable = false;
            text = "test";
        };

        programs.vscode = {
            extensions = [ themeExtension ];
            userSettings = {
                "window.titleBarStyle" = "custom";
                "workbench.colorTheme" = "Temmix";
            };
        };
        
        temmix.templates = [{ 
            input = ./temmix-vscode/themes/Temmix-color-theme-template.json; 
            output = colorThemePath;
        }];
    };
}