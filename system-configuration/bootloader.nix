#* GRUB Bootloader Configuration And Secure Boot Config
{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sbctl # Secure Boot key manager
  ];

  boot.loader = {
    # Lanzaboote currently replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false
    # for now.
    systemd-boot.enable = lib.mkForce false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
      efiInstallAsRemovable = true;

      theme = pkgs.stdenv.mkDerivation {
        pname = "HyperFluent";
        version = "1.0";
        src = pkgs.fetchFromGitHub {
          owner = "Back-Slash-N";
          repo = "HyperFluent-GRUB-Theme";
          rev = "50a69ef1c020d1e4e69a683f6f8cf79161fb1a92";
          hash = "sha256-l6oZqo6ATv9DWUKAe3fgx3c12SOX0qaqfwd3ppcdUZk=";
        };
        installPhase = "cp -r nixos $out";
      };
    };
  };

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    autoEnrollKeys = {
      enable = true;
      autoReboot = false;
    };
  };
}
