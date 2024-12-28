{ lib, config, pkgs, ... } :
let
  	colorRenderedTemplatePath = config.temmix.cacheFile + "/vesktop/temmix-color-theme.css";
		glassRenderedTemplatePath = config.temmix.cacheFile + "/vesktop/temmix-glass-theme.css";
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
      ln -sf ${colorRenderedTemplatePath} ~/.config/vesktop/themes/temmix-color.theme.css
      ln -sf ${glassRenderedTemplatePath} ~/.config/vesktop/themes/temmix-glass.theme.css
    ''];

		temmix.templates = [{ 
			input = ./vesktop-temmix-color-theme.css.inja; 
			output =  colorRenderedTemplatePath;
		}
		{ 
			input = ./vesktop-temmix-glass-theme.css.inja; 
			output =  glassRenderedTemplatePath;
		}];
	};
}