{ lib, config, pkgs, ... } :
{
	options.temmix.targets.gtk = {
		enable = lib.mkOption {
			type = lib.types.bool;
			description = "Enable theming for gtk.";
			default = false;
		};
	};

	config = lib.mkIf (config.temmix.enable && config.temmix.targets.gtk.enable)
	{
    programs.dconf.enable = true;
		environment.systemPackages = [ pkgs.xsettingsd ];
	};
}