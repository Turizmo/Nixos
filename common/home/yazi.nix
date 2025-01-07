 { config, pkgs, ... }:
{
  programs = {
    yazi = { # Terminal-based filebrowser (open by typing yy in the terminal)
      enable = true;
      initLua = ./yazi_init.lua;
      keymap = {
        manager.prepend_keymap = [
          {  on = [ "m" "m" ]; run = "linemode mtimev2"; desc = "Set linemode to modified time"; } # custom linemode to show time in iso format
          {  on = [ "m" "c" ]; run = "linemode ctimev2"; desc = "Set linemode to created time"; }# custom linemode to show time in iso format
        ];
      };
      settings = {
        manager = {
          show_hidden = true;
        };
    };
     };
    bash = {
      enable = true; # bash need to be enabled to create the bashrc file so the yy command can be used to open yazi
    };
  };  
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "text/csv" = ["libreoffice-calc.desktop"];
    };
    defaultApplications = {
      "text/csv" = ["libreoffice-calc.desktop"];
    };
  };
}
