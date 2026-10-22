# Module for flake-parts which exposes the option `gabyx-future`:
# - `gabyx-future`: The evaluated config (e.g. `gabyx-future.text`).
# - `packages.gabyx-future`: Prints the future's text.
# - `lib.future.eval`: Evaluate a custom future outside this flake, e.g.
#    `(lib.future.eval { hobbies = [ "Sailing" ]; }).text`.
{
  lib,
  config,
  ...
}:
let
  future = config.gabyx-future;
in
{
  flake.gabyx-future = future;

  flake.lib.future.eval = cfg: (lib.evalModules { modules = [ ./module.nix cfg ]; }).config;

  perSystem =
    { pkgs, ... }:
    {
      packages.gabyx-future = pkgs.writeShellApplication {
        name = "gabyx-future";
        text = ''cat "${pkgs.writeText "gabyx-future.txt" future.text}"'';
      };
    };
}
