{ lib, config, pkgs, ... } :
let
  	renderedTemplatePath = config.temmix.cacheFile + "/vesktop/temmix-color-theme.css";
in
{
	options.temmix.targets.vesktop = {
		enable = lib.mkOption {
			type = lib.types.bool;
			description = "Enable theming for Vesktop.";
			default = false;
		};
	};

	config = lib.mkIf (config.temmix.enable && config.temmix.targets.vesktop.enable)
	{
    xdg.configFile."vesktop/themes/.keep" = {
      enable = true;
      text = "";
    };

    temmix.commands = [''
      ln -sf ${renderedTemplatePath} ~/.config/vesktop/themes/temmix.theme.css
    ''];

		temmix.templates = [{ 
			input = ./vesktop-temmix-color-theme.css.inja; 
			output =  renderedTemplatePath;
		}];
	};
}