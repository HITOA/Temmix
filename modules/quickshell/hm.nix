{ lib, config, pkgs, ... } :
let
  	renderedTemplatePath = config.temmix.cacheFile + "/quickshell/Temmix.qml";
in
{
	options.temmix.targets.quickshell = {
		enable = lib.mkOption {
			type = lib.types.bool;
			description = "Enable theming for Quickshell.";
			default = false;
		};
	};

	config = lib.mkIf (config.temmix.enable && config.temmix.targets.quickshell.enable)
	{
		temmix.templates = [
			{ 
				input = ./Temmix.qml.inja; 
				output =  renderedTemplatePath;
			}
		];
	};
}