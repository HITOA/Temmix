{ lib, config, pkgs, self, system, ... }: {
    options.temmix = {
        enable = lib.mkEnableOption "Enable temmix.";
    };

    config = 
    let
        setwall = pkgs.writeShellScriptBin "setwall" ''
            if [ "$1" == "" ]; then
                echo "Missing filename."
                exit
            fi

            ${self.packages.${system}.lain} -i $1
        '';
    in
    lib.mkIf config.temmix.enable 
    {
        environment.systemPackages = [ setwall ];
    };
}