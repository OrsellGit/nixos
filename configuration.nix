###*** THE MAIN CONFIGURATION FILE!!! ***###
#? Help is available in the configuration.nix(5) man page
#? and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ./system-configuration/bootloader.nix
    ./system-configuration/cpu-power.nix
    ./system-configuration/graphics.nix
    #./system-configuration/kde.nix
    ./system-configuration/networking.nix
    ./system-configuration/regreet.nix
    ./system-configuration/services.nix
    # ./system-configuration/sops/sops.nix

    ./system-applications/applications.nix
  ];

  # Environment variables that should be set for the whole system.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; #? To encourage electron applications to use Wayland instead of X11
    WLR_NO_HARDWARE_CURSORS = "1";
    __GL_GSYNC_ALLOWED = "1";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "ntfs" ];
  # TODO: Figure out how to get asus armoury driver
  # ];
  #? Enable virtual camera for OBS.
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
    # asus-armoury # ASUS Armoury Crate driver
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  # boot.initrd.kernelModules = [
  #   "nvidia_drm" "nvidia_modeset" "nvidia" "nvidia_uvm"
  # ];

  # Enable Hyprland with UWSM support.
  security.polkit.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  # Universal Wayland Session Manager
  programs.uwsm = {
    enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };
  services.blueman.enable = true; # Bluetooth Connection GUI

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nix.settings = {
    auto-optimise-store = true;

    # Flakes
    experimental-features = [ "nix-command" "flakes" ];
  };
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Define a user account.
  users.users.orsell = {
    isNormalUser = true;
    description = "Some Nerd's Account"; #? This also behaves as the user accounts name on the greeter.
    extraGroups = [ "networkmanager" "wheel" "adbusers" "libvirtd" "users" ];
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  security.pam.services.greetd.enableGnomeKeyring = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}