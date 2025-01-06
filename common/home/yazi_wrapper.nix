{ pkgs, ... }:
let
  yyWrapper = pkgs.writeShellScriptBin "yy" ''
    #!/usr/bin/env bash
    # Run yazi
    yazi "$@"
    
    # Capture the last directory yazi was in
    LAST_DIR=$(yazi -o)
    
    # Change to that directory
    cd "$LAST_DIR"
  '';
in
{
  home.packages = [ yyWrapper ];
}
