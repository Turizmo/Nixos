{ config, pkgs, lib, ...}:

 
let
  shared-clipboard = pkgs.writeShellApplication {
    name = "sClipboard";
    runtimeInputs = [
      pkgs.wl-clipboard
      pkgs.clipnotify
      pkgs.inotify-tools
      ];
    text = ''
  #!/usr/bin/env bash
  inotifywait -m -e modify,create "$1" |
  while read -r directory events filename; do
    echo "Change detected in $directory: $events on $filename"
    done
   '';
  };
in {
  home.packages = [
    shared-clipboard  
  ];

} 
