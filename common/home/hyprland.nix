
{config, pkgs, lib, inputs, ... }:
{	
  wayland.windowManager.hyprland = {
    enable = true;
    # testchange  
        plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
         ];
    settings = {  
       "$wallpaper" = "bash -c 'swww img ~/Wallpaper/wallhaven.jpg --transition-step=20 && fetchWallhaven'";
      input = {
        kb_layout = "no";
        kb_options = "caps:swapescape";
      };
      monitor = ", 3440x1440, auto, 1";
      env = [
        "LIBGL_ALWAYS_SOFTWARE,1"		#needed for virtual machine
        "TERMINAL,alacritty"
      ];
      exec-once = [
        "$wallpaper"
        "waybar"
      ];
      animation = [
        "workspaces, 1, 2, default, slidevert"
        "specialWorkspace, 1, 2, default, fade"
      ]; 
      general = {
        gaps_in = 0;  # set gaps between windows. 
        gaps_out = 20;  # set gaps to screen edge, but disabled on normal workspaces in the workspace rules
        resize_on_border = true;    
      };
      dwindle = {
        force_split = 2; # New windows appear to the right or bottom
        preserve_split = true;
      };
      decoration = {
        rounding = 21;  # General rounding, but rounding is disabled for normal workspaces in the workspace rules
        dim_special = 0.4;
      };
      workspace = [ # Workspace rules
        "s[false], gapsout:0, decorate:false, rounding:false" # Disables gapsout and rounding on nonspesial workspaces
      ];
      "$mod" = "SUPER";

      binde = [
        # Resize window with mainMod + ctrl + arrow keys
        "$mod CONTROL, left, resizeactive, -50 0"
        "$mod CONTROL, right, resizeactive, 50 0"
        "$mod CONTROL, up, resizeactive, 0 -50"
        "$mod CONTROL, down, resizeactive, 0 50"
      ];

      bind =[
        "$mod, T, exec, alacritty"		      	
        "$mod, Q, exec, alacritty"
        "$mod, Return, exec, wofi --show drun"
        "$mod, F, exec, firefox"
        "$mod, C, killactive,"
        "$mod, W, exec, $wallpaper" # change the wallpaper
        "$mod, N, exec, alacritty -e bash -c 'cd ~/nixos && nvim'" # Open configuration files for nixos
        ", Print, exec, grimblast copy area"

        # Move focus with mainMod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move window with mainMod + SHIFT arrow keys
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"


        "$mod, SPACE, togglespecialworkspace"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
      );
    };
  };
}
