{ lib, config, pkgs, ... } :
let
  renderedTemplatePath = config.temmix.cacheFile + "/gtk/gtk-color.css";
	temmixGTKTheme = derivation {
		name = "Temmix-GTK-Theme";
		builder = "${pkgs.bash}/bin/bash";
		args = [ ./build_gtk_theme.sh ];
		coreutils = pkgs.coreutils;
		system = pkgs.stdenv.buildPlatform.system;
		src = ./temmix-gtk;
		color = config.lib.file.mkOutOfStoreSymlink renderedTemplatePath;
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
			iconTheme = {
				name = "Papirus";
				package = pkgs.papirus-icon-theme;
			};
		};

		xdg.configFile = {
			"gtk-4.0/gtk.css".source = "${temmixGTKTheme}/share/themes/temmix/gtk-4.0/gtk.css";
		};

		temmix.commands = [''
			dconf write /org/gnome/desktop/interface/gtk-theme "' '"
			dconf write /org/gnome/desktop/interface/gtk-theme "'temmix'"
		''];

		temmix.templates = [
			{
				input = ./gtk-color.css.inja;
				output = renderedTemplatePath;
			}
		];
	};
}