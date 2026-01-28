#? Handling system wide software.
{ pkgs, ... }:
{
    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
        wget
        tree # display directories in a tree like format
        file # Get file type from terminal
        p7zip # 7zip tool
        zip # normal zip tool
        imagemagick
        gnupg
        btop # System prcocess viewer
        ethtool # TODO-FIXME: Have been needing to use ethtool in order to enable ethernet since it isn't automatically starting it.

        meld

        audacity

        protonup-qt
        protontricks
        wine64

        #tailscale # TODO: Get this working.

        brightnessctl # Laptop screen backlight and button controls # TODO: Implement this into Hyprland binds
        seahorse # GNOME keyring manager # TODO: Replace with kwallet keyring

        teams-for-linux
        thunderbird # Email Client
        maestral-gui

        parsec-bin # Parsec client, it does not host.

        gparted
        ntfs3g # NTFS support
        exfat # exFAT support
        gptfdisk # Set of text-mode partitioning tools for Globally Unique Identifier (GUID) Partition Table (GPT) disks
        woeusb-ng # Windows USB installer maker
    ];

    imports = [
        ./1password.nix
        ./steam.nix
        # ./tailscale.nix
        ./virtual-machines.nix
        ./vr.nix
    ];

    #? Fix unpopulated MIME menus in dolphin
    environment.etc."/xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}