{
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    let
      # Make text file in nix store from msg.
      mkTextFile =
        {
          name,
          from,
          text,
        }:
        pkgs.writeText "${name}-message.txt" ''
          ${text}
          -- ${from}
        '';

      # Generate executable from textfile
      mkStyle =
        runtimeInputs: script: args:
        pkgs.writeShellApplication {
          name = "message-${args.name}";
          inherit runtimeInputs;
          text = ''
            MESSAGE="${mkTextFile args}"
            ${script}
          '';
        };
    in
    {
      messageStyles = {
        plain = mkStyle [ pkgs.coreutils ] ''cat "$MESSAGE"'';

        cowsay = mkStyle [ pkgs.cowsay ] ''cowsay -n < "$MESSAGE"'';

        rainbow = mkStyle [
          pkgs.coreutils
          pkgs.figlet
          pkgs.lolcat
        ] ''{ figlet "Gabyx"; cat "$MESSAGE"; } | lolcat'';

        markdown = mkStyle [ pkgs.glow ] ''glow "$MESSAGE"'';

        dragon = mkStyle [ pkgs.coreutils pkgs.cowsay ] ''
          fmt -w 40 "$MESSAGE" | cowsay -n -f dragon
        '';

        turtle = mkStyle [ pkgs.coreutils pkgs.cowsay ] ''
          fmt -w 40 "$MESSAGE" | cowsay -n -f turtle
        '';

        crab = mkStyle [
          pkgs.coreutils
          pkgs.cowsay
          pkgs.lolcat
        ] ''fmt -w 40 "$MESSAGE" | cowsay -n -f ${./cows/crab.cow} | lolcat -F 0.05 -S 145 '';

      	nixlogo = mkStyle [
      	  pkgs.coreutils
      	  pkgs.cowsay
      	  pkgs.lolcat
      	] ''fmt -w 40 "$MESSAGE" | cowsay -n -f ${./cows/nix.cow} | lolcat -F 0.02 -S 199 '';
      };
    };
}
