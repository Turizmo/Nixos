 { config, pkgs, ... }:
{
  programs = {
    yazi = { # Terminal-based filebrowser
      enable = true;
      initLua = ./yazi_init.lua;
      keymap = {
        manager.prepend_keymap = [
          {  on = [ "m" "m" ]; run = "linemode mtimev2"; desc = "Set linemode to modified time"; }
          {  on = [ "m" "c" ]; run = "linemode ctimev2"; desc = "Set linemode to created time"; }
        ];
      };
      settings = {
        manager = {
          show_hidden = true;
        };
      };
    };
  };

  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "yazi-wrapper" ''
      function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
      }
      y "$@"
    '')
  ];

  home.sessionVariables = {
    PATH = "${config.home.homeDirectory}/.nix-profile/bin:${config.home.sessionVariables.PATH}";
  };
}
