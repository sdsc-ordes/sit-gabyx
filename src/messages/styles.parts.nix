{
  lib,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    let
      msgWidth = 40;

      # Make text file in nix store from msg.
      # The text is wrapped to `width` columns unless `wrap` is false.
      mkTextFile =
        { wrap }:
        {
          name,
          from,
          text,
        }:
        pkgs.runCommand "${name}-message.txt"
          {
            inherit text;
            passAsFile = [ "text" ];
          }
          ''
            {
              ${if wrap then ''fmt -w ${toString msgWidth} "$textPath"'' else ''cat "$textPath"''}
              echo
              echo ${lib.escapeShellArg "-- ${from}"}
            } > "$out"
          '';

      # Generate executable from textfile
      mkStyleWith =
        {
          wrap ? true,
        }:
        runtimeInputs: script: args:
        pkgs.writeShellApplication {
          name = "message-${args.name}";
          inherit runtimeInputs;
          text = ''
            MESSAGE="${mkTextFile { inherit wrap; } args}"
            ${script}
          '';
        };

      mkStyle = mkStyleWith { };
    in
    {
      messageStyles = {
        plain = mkStyle [ pkgs.coreutils ] ''cat "$MESSAGE"'';

        cowsay = mkStyle [ pkgs.cowsay ] ''cowsay -n < "$MESSAGE"'';

        rainbow = mkStyle [
          pkgs.coreutils
          pkgs.figlet
          pkgs.lolcat
        ] ''{ figlet "Gabyx"; cat "$MESSAGE"; } | lolcat -f'';

        # Glow does its own wrapping and `fmt` would break markdown syntax.
        markdown = mkStyleWith { wrap = false; } [ pkgs.glow ] ''glow "$MESSAGE"'';

        dragon = mkStyle [ pkgs.cowsay ] ''cowsay -n -f dragon < "$MESSAGE"'';

        turtle = mkStyle [ pkgs.cowsay ] ''cowsay -n -f turtle < "$MESSAGE"'';

        crab = mkStyle [
          pkgs.cowsay
          pkgs.lolcat
        ] ''cowsay -n -f ${./cows/crab.cow} < "$MESSAGE" | lolcat -f -F 0.05 -S 145'';

        nixlogo = mkStyle [
          pkgs.cowsay
          pkgs.lolcat
        ] ''cowsay -n -f ${./cows/nix.cow} < "$MESSAGE" | lolcat -f -F 0.02 -S 199'';

        kitty = mkStyle [
          pkgs.cowsay
          pkgs.lolcat
        ] ''cowsay -n -f ${./cows/kitty.cow} < "$MESSAGE" | lolcat -f'';

        heart = mkStyle [
          pkgs.toilet
          pkgs.lolcat
        ] ''{ toilet --gay -f mono9 "nix <3"; lolcat -f "$MESSAGE"; }'';

        shrek = mkStyle [
          pkgs.cowsay
          pkgs.lolcat
        ] ''cowsay -n -f ${./cows/shrek.cow} < "$MESSAGE" | lolcat -f'';

      };
    };
}
