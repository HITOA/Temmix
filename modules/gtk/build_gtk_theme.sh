export PATH="$coreutils/bin"

mkdir -p $out/share/themes
cp -r $src $out/share/themes/temmix
ln -s $color $out/share/themes/temmix/gtk-3.0/gtk-color.css