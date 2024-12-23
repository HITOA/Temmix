{ lib, ... }:
{
  options.temmix.opacity = {
    terminal = lib.mkOption {
      description = "The opacity of the terminal's window between 0.0 and 1.0.";
      type = lib.types.float;
      default = 1.0;
    };
  };
}