{ config
, pkgs
, inputs
, lib
, sops-nix
, ... }:

{
  home.username = "orsell";
  home.homeDirectory = "/home/orsell";

  #? Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    lutris
    gale
    modrinth-app

    qbittorrent
    vpkedit
    bottles # Wine
    jdk21 # J*va
    gimp
    uget
    mpv # Media Player
    vlc # Another Media Player
    pavucontrol # Volume Control

    kdePackages.kdenlive # Video Editor
    kdePackages.dolphin # File Manager
    kdePackages.qtsvg # Add support for SVG icons in Dolphin
    kdePackages.kio-fuse # To mount remote filesystems via FUSE
    kdePackages.kio-extras # Extra protocols support (sftp, fish and more)
    kdePackages.kate # Small text editor
    kdePackages.powerdevil # Manages the power consumption settings of a Plasma shell
    kdePackages.kwallet # The KDE wallet
    kdePackages.print-manager # Printing and printer manager
    kdePackages.kservice
    kdePackages.gwenview # Image viewer by KDE
    kdePackages.ark # Graphical file compression/decompression utility

    kdePackages.okular # PDF viewer
    libreoffice-qt6-fresh # The LibreOffice suite
    obsidian # Markdown knowledge base program

    gitkraken
    maestral

    nerd-fonts.jetbrains-mono
  ];

  # TODO: Figure out how to disable bottles warning message.
  # programs.bottles = {
  #   enable = true;
  #   removeWarningPopup = true;
  # };

  imports = [
    ./home-manager/discord/nixcord.nix
    ./home-manager/hyprland/hyprland.nix
    ./home-manager/hyprland/waybar.nix
    ./home-manager/notification-daemon.nix
    ./home-manager/quickshell/quickshell.nix
    ./home-manager/rofi/rofi.nix
    ./home-manager/steam/steam.nix
    ./home-manager/term-shell/term-shell.nix
    ./home-manager/term-shell/fastfetch/fastfetch.nix
    ./home-manager/vscode/vscode.nix
    ./home-manager/firefox.nix
    ./home-manager/git.nix
    ./home-manager/jetbrains.nix
    ./home-manager/obs.nix
    ./home-manager/system-theme.nix
    ./home-manager/xdg.nix
  ];

  fonts.fontconfig.enable = true; #? Allow HM to discover installed fonts.

  #? Environment variables set for the user.
  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/.1password/agent.sock"; #? Makes sure 1Password is used with SSH
  };

  # Secret Management
  #sops = {
  #  defaultSopsFile = ./system-configuration/sops/secrets/secrets.yaml;
  #  defaultSopsFormat = "yaml";
  #  defaultSymlinkPath = "/run/user/1000/secrets";
  #  defaultSecretsMountPoint = "/run/user/1000/secrets.d";
  #  #age.keyFile = "/home/orsell/.config/sops/age/keys.txt";
  #  secrets.discord-token = { path = "${config.sops.defaultSymlinkPath}/discord-token"; };
  #};


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  #? Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
