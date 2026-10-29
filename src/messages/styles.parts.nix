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
        ] ''{ figlet "Gabyx"; cat "$MESSAGE"; } | lolcat -f'';

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
        ] ''fmt -w 40 "$MESSAGE" | cowsay -n -f ${./cows/crab.cow} | lolcat -f -F 0.05 -S 145 '';

        nixlogo = mkStyle [
          pkgs.coreutils
          pkgs.cowsay
          pkgs.lolcat
        ] ''fmt -w 40 "$MESSAGE" | cowsay -n -f ${./cows/nix.cow} | lolcat -f -F 0.02 -S 199 '';

        kitty = mkStyle [
          pkgs.coreutils
          pkgs.cowsay
          pkgs.lolcat
        ] ''fmt -w 40 "$MESSAGE" | cowsay -n -f ${./cows/kitty.cow} | lolcat -f'';

        heart = mkStyle [
          pkgs.coreutils
          pkgs.toilet
          pkgs.lolcat
        ] ''{ toilet --gay -f mono9 "nix <3"; cat "$MESSAGE" | fmt -w 40 | lolcat -f; }'';

      };
    };
}
