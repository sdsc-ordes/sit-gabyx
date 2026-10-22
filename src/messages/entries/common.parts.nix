{
  ...
}:
{
  perSystem =
    { ... }:
    {
      messages.common = {
        from = "The SIT Team";
        text = ''
          Thanks for making our builds reproducible
          and our lives a bit more declarative!
        '';
      };

      messages.deterministic-cow = {
        from = "Nix cow";
        style = "cowsay";
        text = "Moo! Everything is a derivation.";
      };
    };
}
