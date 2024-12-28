{ lib, config, pkgs, ... } :
let
  renderedTemplatePath = config.temmix.cacheFile + "/gtk/gtk-color.css";
	temmixGTKTheme = derivation {
		name = "Temmix-GTK-Theme";
		builder = "${pkgs.bash}/bin/bash";
		args = [ ./build_gtk_theme.sh ];
		coreutils = pkgs.coreutils;
		system = "x86_64-linux";
		src = ./temmix-gtk;
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
				package = temmixGTKTheme;
			};
		};

		temmix.templates = [
			{
				input = ./gtk-color.css.inja;
				output = renderedTemplatePath;
			}
		];
	};
}