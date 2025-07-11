{ lib, config, pkgs, ... } : 
let
    renderedTemplatePath = config.temmix.cacheFile + "/vscode/temmix-color-theme.json";
    themeExtension = pkgs.runCommandLocal "temmix-vscode" {
        vscodeExtUniqueId = "temmix.temmix";
        vscodeExtPublisher = "temmix";
        version = "0.0.0";
    } ''
        mkdir -p "$out/share/vscode/extensions/$vscodeExtUniqueId/themes"
        ln -s ${renderedTemplatePath} "$out/share/vscode/extensions/$vscodeExtUniqueId/themes/Temmix-color-theme.json"
        ln -s ${./temmix-vscode/package.json} "$out/share/vscode/extensions/$vscodeExtUniqueId/package.json"
    '';
in
{
    options.temmix.targets.vscode = {
        enable = lib.mkOption {
            type = lib.types.bool;
            description = "Enable theming for VSCode.";
            default = config.programs.vscode.enable;
        };
    };

    config = lib.mkIf (config.temmix.enable && config.temmix.targets.vscode.enable)
    {
        programs.vscode.profiles.default = {
            extensions = [ themeExtension ];
            userSettings = {
                "window.titleBarStyle" = "custom";
                "workbench.colorTheme" = "Temmix";
            };
        };
        
        temmix.templates = [{ 
            input = ./temmix-vscode/themes/Temmix-color-theme-template.json; 
            output =  renderedTemplatePath;
        }];
    };
}