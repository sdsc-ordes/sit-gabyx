{
  lib,
  flake-parts-lib,
  ...
}:
let
  inherit (flake-parts-lib) mkPerSystemOption;
in
{
  options.perSystem = mkPerSystemOption {
    options.messageStyles = lib.mkOption {
      description = ''
        Attrset of message styles keyed by style name.
        Each style is a function `{ name, from, text } -> package` which
        builds a small executable displaying the message.
      '';
      default = { };
      type = lib.types.attrsOf (lib.types.functionTo lib.types.package);
    };

    options.messages = lib.mkOption {
      description = "Messages to Gabyx.";
      default = { };
      type = lib.types.attrsOf (
        lib.types.submodule (
          { name, ... }:
          {
            options = {
              from = lib.mkOption {
                type = lib.types.str;
                default = name;
                description = "The message author.";
              };

              text = lib.mkOption {
                type = lib.types.str;
                description = "The message itself.";
              };

              style = lib.mkOption {
                type = lib.types.str;
                default = "plain";
                description = "The style (must be defined as `messageStyles`) used to display the message.";
              };
            };
          }
        )
      );
    };
  };
}
