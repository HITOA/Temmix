{ lib, config, pkgs, ... } :
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
		temmix.templates = [{ 
			input = ./vesktop-temmix-color-theme.css.inja; 
			output =  xdg.configHome + "/vesktop/themes/temmix.theme.css"; #Didn't find a better way
		}];
	};
}