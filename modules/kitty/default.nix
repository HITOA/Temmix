{ lib, config, pkgs, ... } :
let
  	renderedTemplatePath = config.temmix.cacheFile + "/kitty-temmix-color-theme.conf";
in
{
	options.temmix.kitty = {
		enable = lib.mkOption {
			type = lib.types.bool;
			description = "Enable theming for Kitty Terminal.";
			default = config.programs.kitty.enable;
		};
	};

	config = lib.mkIf (config.temmix.enable && config.temmix.kitty.enable)
	{
		config.temmix.terminal.enable = true;

		programs.kitty = {
			settings.background_opacity = "${builtins.toString config.temmix.opacity.terminal}";
			extraConfig = ''
				include ${renderedTemplatePath}
			'';
		};
		
		temmix.templates = [{ 
			input = ./kitty-temmix-color-theme.conf.inja; 
			output =  renderedTemplatePath;
		}];
	};
}