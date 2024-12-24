{ lib, config, pkgs, ... } :
let
  	renderedTemplatePath = config.temmix.cacheFile + "/vesktop-temmix-color-theme.css";
in
{
	options.temmix.vesktop = {
		enable = lib.mkOption {
			type = lib.types.bool;
			description = "Enable theming for Vesktop.";
			default = false;
		};
	};

	config = 
  let
    vesktopTheme = pkgs.runCommandLocal "temmix-vesktop-theme" 
    {
      inherit (xdg) configHome;
    } ''
      mkdir -p $configHome/vesktop/themes
      ln -sf ${renderedTemplatePath} $configHome/vesktop/themes/temmix.theme.css
      touch $out/.keep
    '';
  in
  lib.mkIf (config.temmix.enable && config.temmix.vesktop.enable)
	{
    home.packages = [
      vesktopTheme
    ];

		temmix.templates = [{ 
			input = ./vesktop-temmix-color-theme.css.inja; 
			output =  renderedTemplatePath;
		}];
	};
}