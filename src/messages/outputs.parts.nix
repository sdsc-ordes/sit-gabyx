{
  lib,
  ...
}:
{
  perSystem =
    { config, pkgs, ... }:
    let
      messagePkgs = lib.mapAttrs' (
        name: msg:
        lib.nameValuePair "message-${name}" (
          config.messageStyles.${msg.style} {
            inherit name;
            inherit (msg) from text;
          }
        )
      ) config.messages;
    in
    {
      packages = messagePkgs // {
        messages = pkgs.writeShellApplication {
          name = "messages";
          text = lib.concatMapStringsSep "\n" (p: ''
            ${lib.getExe p}
            echo
          '') (lib.attrValues messagePkgs);
        };
      };
    };
}
