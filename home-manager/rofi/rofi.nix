{ pkgs, ... }:
{
    home.file.".config/rofi/themes" = {
        source = ./themes;
        recursive = true;
    };

    programs.rofi = {
        enable = true;
        location = "bottom";
        theme = "~/.config/rofi/themes/catppuccin-macchiato.rasi";
        plugins = with pkgs; [ rofi-calc rofi-emoji rofi-power-menu ];
        font = "JetBrains Mono Regular 13";
    };
}