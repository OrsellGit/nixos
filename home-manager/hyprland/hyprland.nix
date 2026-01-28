#* DISPLAY/WINDOW MANAGER
{ pkgs, lib, ... }:
{
  imports = [
    ./hypridle.nix #? Hyprland "Screen Saver"
    ./hyprlock.nix #? Hyprland Lock Screen
  ];

  #? WALLPAPERS
  # TODO: Implement rest of backgrounds
  home.file = {
    ".wallpapers" = { source = ../../wallpapers; recursive = true; };
    ".wallpapers/wallpaper-d.sh" = { source = ./wallpaper-d.sh; executable = true; };
  };

  home.packages = with pkgs; [
    hyprpolkitagent # Authentication Manager
    mpvpaper # Video Wallpaper Manager
    #grim # Screenshot utils (x3)
    slurp
    grimblast
    flameshot
    swappy
    wl-clipboard
    font-awesome
    jq # Used for detecting if a special workspace is active when switching to a numbered workspace
  ];

  # TODO: Change out cursor, as well as change the one GTK applicaitons use to the same so its consistent.
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    settings = { # TODO: Port this all to a hyprland.conf file instead of all being crammed into here.
      exec-once = [
        "systemctl --user enable --now hyprpolkitagent.service"
        "systemctl --user enable --now hypridle.service"
        "systemctl --user enable --now waybar.service"
        "rog-control-center" # ASUS system control, supergfx and asusctl.
        "1password --silent" # Startup 1Password in the background.
        "maestral" # Maestral, dropbox alternative

        #"~/.wallpapers/wallpaper-d.sh" # Wallpapers.
        "[workspace 1 silent] kitty tmux"
        #"[workspace 1 silent] code"
        #"[workspace 2 silent] firefox"
        "[workspace 9 silent] kitty btop"
        "[workspace 9 silent] kitty nvitop"
        "[workspace special:magic silent] equibop"
        "[workspace special:magic silent] teams-for-linux"
        "[workspace special:magic silent] thunderbird"
      ];

      "monitor" = [
        "eDP-1, 2560x1600@240, auto-right, 1.0"
        "eDP-2, 2560x1600@240, auto-right, 1.0" # For some reason, I believe it was when I was tweaking NVIDIA settings, it made a seperate display screen for when it's driven by the GPU.
        "desc:LG Electronics LG ULTRAGEAR 0x00085DEB, preferred, 0x0, 0.8" # Home LG monitor
        "desc:ViewSonic Corporation VA2451 SERIES T1Y134120750, 1920x1080@60, auto-right, 1.0" # DigiPen monitor.
        "desc:Philips Consumer Electronics Company PHL 288E2 AU52119000013, 3840x2160@60, auto-left, 1.0"
        ", preferred, auto-right, 1.0" # Any new monitors will be placed to the right of all monitors with its preferred resoluttion.
      ];

      "$terminal" = "kitty";
      "$mod" = "alt";

      bind = [
        # Application menu
        "SUPER, SUPER_L, exec, pkill rofi || rofi -show drun"
        "$mod, TAB, exec, pkill rofi || rofi -show window"

        # Lock computer
        "SUPER, l, exec, hyprlock"

        # Terminal Shortcut
        "$mod, q, exec, $terminal tmux"

        # Selective Screenshot
        "SUPER_SHIFT, s, exec, ~/.config/hypr/scripts/screenshot rc"
        #"SUPER_SHIFT, s, exec, flameshot gui --clipboard"

        # OBS Clip Hotkey
        ", F8, pass, class:^(com\.obsproject\.Studio)$"

        # ", code:156,

        # Open 1Password quick access menu.
        "control SHIFT, SPACE, exec, 1password --quick-access"

        # Close Window
        "$mod, w, killactive"

        # Pin window to make it always visible on all workspaces
        "$mod, p, pin"

        # Floating windows
        "SUPER, f, togglefloating"

        # Execution
        # ", code:87, exec, ~/.discord-slasher.sh 0" # Orsell
        # ", code:88, exec, ~/.discord-slasher.sh 1" # Bob
        # ", code:89, exec, ~/.discord-slasher.sh 2" # Deepfried
        # ", code:83, exec, ~/.discord-slasher.sh 0 1"
        # ", code:84, exec, ~/.discord-slasher.sh 1 1"
        # ", code:85, exec, ~/.discord-slasher.sh 2 1"

        # Move application between workspaces
        "SUPER_SHIFT, 1, movetoworkspace, 1"
        "SUPER_SHIFT, 2, movetoworkspace, 2"
        "SUPER_SHIFT, 3, movetoworkspace, 3"
        "SUPER_SHIFT, 4, movetoworkspace, 4"
        "SUPER_SHIFT, 9, movetoworkspace, 9"
        "SUPER_SHIFT, 5, movetoworkspace, 5"
        "SUPER_SHIFT, 6, movetoworkspace, 6"
        "SUPER_SHIFT, 7, movetoworkspace, 7"
        "SUPER_SHIFT, 8, movetoworkspace, 8"

        # Overlayed workspace (like steam ingame overlay)
        "$mod, d, togglespecialworkspace, magic"
        "$mod SHIFT, d, movetoworkspace, special:magic"
        "$mod CONTROL, d, movetoworkspace, 1"

        # Workspaces
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, mouse_down, workspace, e-1"
        "SUPER, mouse_up, workspace, e+1"

        # Hide Special workspaces if active
        # Taken from https://www.reddit.com/r/hyprland/comments/1b6bf39/comment/ktfscyz/
        "SUPER, 1, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"
        "SUPER, 2, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"
        # "SUPER, 3, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"
        "SUPER, 4, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"
        "SUPER, 5, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"
        "SUPER, 6, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"
        "SUPER, 7, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"
        "SUPER, 8, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"
        "SUPER, 9, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"
        "SUPER, mouse_down, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"
        "SUPER, mouse_up, exec, hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name' | sed 's/special://' | xargs -I [] hyprctl dispatch togglespecialworkspace []"

      ];

      bindm = [
        # Floating windows
        "alt, mouse:272, movewindow"
      ];

      binds = {
        "scroll_event_delay" = "0";
        "drag_threshold" = "10";
      };

      input = {
        # "name" = "sigmachip-usb-mouse";
        "sensitivity" = "0.2";
        "accel_profile" = "flat";
        "follow_mouse" = "2";
      };

      general = {
        "col.active_border" = "rgb(27F274) rgb(3BFFFF) 45deg";
        "col.inactive_border" = "rgb(ffff50) rgb(c97d2d) 45deg";

        "border_size" = "4";
        "resize_on_border" = "true";
        "extend_border_grab_area" = "10";
        "hover_icon_on_border" = "true";
      };

      decoration = {
        # "rounding" = "5";
        # "rounding_power" = "4";
        # "inactive_opacity" = "0.9";
        # shadow = {
        #   "enabled" = "true";
        #   "range" = "10";
        #   "color" = "rgb(0, 0, 0)";
        # };
      };

      animations = {
        "animation" = "specialWorkspace, 1, 3, default, slidefadevert -50%";
      };

      misc = {
        "focus_on_activate" = "true";
        "disable_hyprland_logo" = "true";
      };

      windowrule = [
        "opacity .95 override .95, class:Code"
        #"workspace 1, class:Code"
        "bordercolor rgb(6600a1) rgb(ff5100) 0deg rgb(6600a1) rgb(ff5100) 0deg,floating:1"
        "workspace special:magic, class:vesktop"
        "bordersize 0, pinned:1"
        "float, initialTitle:Picture-in-Picture"
        "pin, initialTitle:Picture-in-Picture"
        "size 552 310, initialTitle:Picture-in-Picture"
        "float, initialTitle:Discord Popout"
        "pin, initialTitle:Discord Popout"
        "size 552 310, initialTitle:Discord Popout"
      ];
    };
    extraConfig = ''
      # Toggle ignoring non-special workspace binds
      bind=$mod, ESCAPE, exec, notify-send "Game Mode Enabled!"
      bind=$mod, ESCAPE, submap, gamemode
      submap = gamemode

      # Toggle off
      bind=$mod, ESCAPE, exec, notify-send "Game Mode Disabled!"
      bind=$mod, ESCAPE, submap, reset

      # Keep overlay workspace
      bind=$mod, d, togglespecialworkspace, magic

      # OBS Clip Hotkey
      bind=, F8, pass, class:^(com\.obsproject\.Studio)$

      # Full Screenshot
      bind=SUPER_SHIFT, s, exec, ~/.config/hypr/scripts/screenshot sc

      # End of special bind set
      submap = reset

      # Fixes issue with Jetbrains where it struggles with moving tabs and issues with hiding other windows because it thinks there's no input.
      # fix tooltips (always have a title of `win.<id>`)
      windowrulev2 = noinitialfocus, class:^(.*jetbrains.*)$, title:^(win.*)$
      windowrulev2 = nofocus, class:^(.*jetbrains.*)$, title:^(win.*)$
      # fix tab dragging (always have a single space character as their title)
      windowrulev2 = noinitialfocus, class:^(.*jetbrains.*)$, title:^\\s$
      windowrulev2 = nofocus, class:^(.*jetbrains.*)$, title:^\\s$

      env = GBM_BACKEND,nvidia-drm
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = LIBVA_DRIVER_NAME,nvidia

      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
    '';
  };

  #? Screenshot Script For Hyprland
  # TODO: Update this script file to use flameshot and grimblast
  home.file.".config/hypr/scripts/screenshot" = {
    executable = true;
    source = ./screenshot;
  };
}
