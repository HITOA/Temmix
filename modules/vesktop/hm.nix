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

	config = lib.mkIf (config.temmix.enable && config.temmix.vesktop.enable)
	{
    home.file."${xdg.configHome}/vesktop/themes/temmix.theme.css" = {
      enable = true;
      source = renderedTemplatePath;
    };

		temmix.templates = [{ 
			input = ./vesktop-temmix-color-theme.css.inja; 
			output =  renderedTemplatePath;
		}];
	};
}