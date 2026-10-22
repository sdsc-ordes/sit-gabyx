# Module for flake-parts which declares the top-level option `gabyx-future`.
# Any flake-parts module can set its attributes, e.g.
#
#   ```nix
#   { gabyx-future.hobbies = [ "Sailing" ]; }
#   ```
{
  lib,
  ...
}:
{
  options.gabyx-future = lib.mkOption {
    description = "The future of Gabyx. See `./module.nix` for all attributes.";
    type = lib.types.submodule ./module.nix;
    default = { };
  };

  options.flake.lib.future = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    description = "Functions to evaluate `gabyx-future` configs.";
    default = { };
  };
}
