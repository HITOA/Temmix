export PATH="$coreutils/bin"

mkdir -p $out/share/themes/temmix
cp -r $src/gtk-3.0 $out/share/themes/temmix/gtk-3.0
cp -r $src/gtk-4.0 $out/share/themes/temmix/gtk-4.0
ln -s $color $out/share/themes/temmix/gtk-color.css