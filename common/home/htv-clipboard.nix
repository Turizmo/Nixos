{ config, pkgs, lib, ...}:

let
  htv-clipboard = pkgs.writeShellApplication {
    name = "htvClipboard";
    runtimeInputs = [
      pkgs.wl-clipboard
    ];
    text = ''
      #!/usr/bin/env bash

      FILE="$1/htv_clipboard.txt"
      LAST_MODIFIED=$(stat -c %Y "$FILE")

      while :; do
        sleep 0.2
        NEW_MODIFIED=$(stat -c %Y "$FILE")

        if [ "$NEW_MODIFIED" -ne "$LAST_MODIFIED" ]; then
          wl-copy < "$FILE"
          echo "Change detected in $FILE"
          LAST_MODIFIED=$NEW_MODIFIED
        fi
      done
    '';
  };
in {
  home.packages = [
    htv-clipboard  
  ];
}
