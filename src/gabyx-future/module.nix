# Plain module describing Gabyx' future. Set attributes and read the rendered `text`.
# Used as the submodule type of the flake-parts option `gabyx-future`
# (see `./options.parts.nix`) and by `lib.future.eval`.
{
  lib,
  config,
  ...
}:
{
  options = {

    nextJob = {
      environment = {
        happiness = {
          enable = lib.mkEnableOption "an open-minded, friendly and appreciating environment.";
        };
        ai-slop = {
          enable = lib.mkEnableOption "high abundance of ai driven entropy.";
        };
      };

      computer = {
        partitions = {
          windows = {
            enable = lib.mkEnableOption "has a windows partition.";
          };
          macos = {
            enable = lib.mkEnableOption "has a macos partition.";
          };
          linux = {
            enable = lib.mkEnableOption "has a linux partition.";
            os = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = "NixOS";
              description = "Name of the linux distribution used.";
            };
          };
        };
      };
    };

    text = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      description = "The rendered future.";
    };
  };

  config.text =
    let
      inherit (config.nextJob) environment;
      inherit (config.nextJob.computer) partitions;

      lines = [
        "Gabyx's next work challenge :"
      ]
      ++ lib.optional (!environment.happiness.enable) "- This is not the right place - move on!"
      ++ lib.optional environment.ai-slop.enable "- Oof, maybe worth considering carpentry?"
      ++ lib.optional partitions.windows.enable "- RUUUUUUUUN FAST!!"
      ++ lib.optional partitions.macos.enable "- RUUUUUUUUN!!"
      ++ lib.optional (
        partitions.linux.enable && partitions.linux.os == "NixOS"
      ) "- NixOS! There we go - let's start!";
    in
    lib.concatStringsSep "\n" lines + "\n";
}
