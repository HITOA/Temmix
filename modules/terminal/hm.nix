{ lib, config, pkgs, ... } :
let
  	renderedTemplatePath = config.temmix.cacheFile + "/set-terminal-color.sh";
in
{
	options.temmix.targets.terminal = {
		enable = lib.mkOption { #No description because this should not be enabled directly
			type = lib.types.bool;
			default = false;
		};
	};

	config = lib.mkIf (config.temmix.enable && config.temmix.targets.terminal.enable)
	{
		#Will have to change that if I want to support darwin I believe. But do I want to support darwin ? that is the question.
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