{ lib, config, pkgs, osConfig, ... } : 
let
    themeExtension = pkgs.runCommandLocal "temmix-vscode" {
        vscodeExtUniqueId = "temmix.temmix";
    } ''
        mkdir -p "$out/share/vscode/extensions/$vscodeExtUniqueId/themes"
        ln -s ${./vscode/themes/Temmix-color-theme.json} "$out/share/vscode/extensions/$vscodeExtUniqueId/themes/Temmix-color-theme.json"
        ln -s ${./vscode/package.json} "$out/share/vscode/extensions/$vscodeExtUniqueId/package.json"
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

    config = lib.mkIf (osConfig.enable && config.temmix.vscode.enable)
    {
        programs.vscode = {
            extensions = [ themeExtension ];
            userSettings = {
                "window.titleBarStyle" = "custom";
                "workbench.colorTheme" = "Temmix";
            };
        };

        osConfig.templates = [{
            input = ./.vscode/themes/Temmix-color-theme-template.json;
            output = ./.vscode/themes/Temmix-color-theme.json;
        }];
    };
}