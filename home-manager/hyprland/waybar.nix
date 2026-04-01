{ pkgs, ... }:
{
  # TODO: Finish customizing waybar
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
  };

  home.file = {
    #".config/waybar/config.jsonc".source = ./waybar/config.jsonc;
    #".config/waybar/style.css".source = ./waybar/style.css;
  };
}
