{ config, pkgs, lib, ...}:

 
let
  htv-clipboard = pkgs.writeShellApplication {
    name = "htvClipboard";
    runtimeInputs = [
      pkgs.wl-clipboard
      pkgs.clipnotify
      pkgs.inotify-tools
      ];
    text = ''
  #!/usr/bin/env bash
  inotifywait -m -e modify,create "$1" |
  while read -r directory events filename; do
    wl-copy < "$1/htv_clipboard.txt"
    echo "Change detected in $directory: $events on $filename"
  done

   '';
  };
in {
  home.packages = [
    htv-clipboard  
  ];
  # test2
} 
