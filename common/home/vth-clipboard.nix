{ config, pkgs, lib, ...}:

 
let
  vth-clipboard = pkgs.writeShellApplication {
    name = "vthClipboard";
    runtimeInputs = [
      pkgs.wl-clipboard
      pkgs.clipnotify
      pkgs.inotify-tools
      ];
    text = ''
  #!/usr/bin/env bash
  # inotifywait -m -e modify,create "$1" |
  # while read -r directory events filename; do
  #   echo "Change detected in $directory: $events on $filename"
  #   done

  output_file="$1/vth_clipboard.txt"

  while clipnotify; do
    
    wl-paste --type text/plain > "$output_file" 
    echo "Clipboard saved to file"
  done
   '';
  };
in {
  home.packages = [
    vth-clipboard  
  ];
  # test2
} 
