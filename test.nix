attrs: { lib, ... }: {
  a = lib.mkIf (lib.isAttrs attrs) (builtins.)
}