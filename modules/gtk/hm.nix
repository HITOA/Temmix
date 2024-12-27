{ lib, config, pkgs, ... } :
let
	temmixGTKTheme = derivation {
		name = "Temmix GTK Theme";
		builder= "${pkgs.bash}/bin/bash";
		args = [ ./build_gtk_theme.sh ]
		inherit (pkgs) coreutils;
		system = builtins.currentSystem;
	};
in
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
    gtk = {
			enable = true;
			theme = {
				name = "temmix";
				package = temmixGTKTheme
			};
		};
	};
}