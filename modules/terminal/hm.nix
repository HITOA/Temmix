{ lib, config, pkgs, ... } :
let
  	renderedTemplatePath = config.temmix.cacheFile + "/set-terminal-color.sh";
in
{
	options.temmix.targets.terminal = {
		enable = lib.mkOption {
			type = lib.types.bool;
			description = "Enable theming for Any Terminal.";
			default = false;
		};
	};

	config = lib.mkIf (config.temmix.enable && config.temmix.targets.terminal.enable)
	{
		temmix.commands = [''
for i in "/dev/pts/[0-9]*"; do
	source ${renderedTemplatePath} | tee ''${i}
done
    	''];

		temmix.templates = [{ 
			input = ./set-terminal-color.sh.inja; 
			output =  renderedTemplatePath;
		}];
	};
}