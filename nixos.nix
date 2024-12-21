lain: homeManagerModule: {
    imports = [ (import ./temmix.nix lain) (import ./hm-integration.nix homeManagerModule) ];
}