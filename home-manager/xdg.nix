#? XDG Configuration
{ pkgs, ... }:
{
  xdg = {
    desktopEntries = {
      code = {
        name = "Visual Studio Code";
        genericName = "Code Editor";
        exec = "code %U";
        icon = "code";
        terminal = false;
        categories = [ "Application" ];
        mimeType = [ "text/html" "text/xml" ];
      };

      vlc = {
        name = "VLC";
        genericName = "VLC Media Player";
        exec = "vlc %U";
        icon = "vlc";
        terminal = false;
        categories = [ "Application" ];
        mimeType = [ "video/*" ];
      };

      mpv = {
        name = "MPV";
        genericName = "MPV";
        exec = "mpv %U";
        terminal = false;
        categories = [ "Application" ];
        mimeType = [ "video/*" ];
      };

      # nemo = {
      #     name = "Nemo";
      #     exec = "${pkgs.nemo-with-extensions}/bin/nemo";
      # };

      # kitty = {
      #   name = "kitty";
      #   genericName = "Terminal emulator";
      #   exec = "kitty --start-as=fullscreen"; # this is the main fix and the rest is to conform with original
      #   icon = "kitty";
      #   comment = "Fast, feature-rich, GPU based terminal";
      #   categories = [ "System" "TerminalEmulator" ];
      #   settings = {
      #     TryExec = "kitty";
      #   };
      # };
    };

    #menus.enable = true;

    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = ["code.desktop"];
        "image/*" = ["gwenview.desktop"];
        "video/*" = ["mpv.desktop"];
        "inode/directory" = [ "dolphin.desktop" ]; # TODO-FIXME: Not working? xdb-open is not using this?
        "application/x-gnome-saved-search" = [ "dolphin.desktop" ];
        "applicaiton/zip" = [ "org.kde.ark.desktop" ];
      };
    };
  };
}
