{ lib, config, pkgs, ... } :
let
  	renderedTemplatePath = config.temmix.cacheFile + "/set-terminal-color.sh";
in
{
	options.temmix.terminal = {
		enable = lib.mkOption {
			type = lib.types.bool;
			description = "Enable theming for Any Terminal.";
			default = false;
		};
	};

	config = lib.mkIf (config.temmix.enable && config.temmix.terminal.enable)
	{
		temmix.commands = [''
      source ${renderedTemplatePath}
    ''];

		temmix.templates = [{ 
			input = ./set-terminal-color.sh.inja; 
			output =  renderedTemplatePath;
		}];
	};
}