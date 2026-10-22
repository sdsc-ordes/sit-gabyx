# The default configuration of `gabyx-future`.
# See `./module.nix` for all available attributes.
{
  ...
}:
{
  gabyx-future = {
    nextJob = {
      environment = {
        happiness.enable = true;
        ai-slop.enable = false;
      };
      computer.partitions = {
        macos.enable = false;
        windows.enable = false;
        linux = {
          enable = true;
          os = "NixOS";
        };
      };
    };
  };
}
