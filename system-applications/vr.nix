#* VR Application Configuration
{ pkgs, ... }:
{
    #? Install additional VR applications for home manager.
    home-manager.users.orsell.home.packages = with pkgs; [
        alvr
        sidequest
        bs-manager # Beat Saber Mod Manager
        wayvr-dashboard
        wivrn
    ];

    #? WiVRn
    services.wivrn = {
        enable = true;
        openFirewall = true;
        defaultRuntime = true;
        steam.importOXRRuntimes = true; #! I don't believe this is working but worth putting here just in case.
        # Config for WiVRn (https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md)
        config = {
            enable = true;
            json = {
                # 1.0x foveation scaling
                scale = 1.0;
                # 70 Mb/s
                bitrate = 70000000;
                encoders = [
                    {
                        encoder = "vulkan";
                        codec = "h264";
                        # 1.0 x 1.0 scaling
                        width = 1.0;
                        height = 1.0;
                        offset_x = 0.0;
                        offset_y = 0.0;
                    }
                ];
            };
        };
    };
}