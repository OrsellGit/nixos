#* Laptop CPU and Power Management
{ ... }:
{
    # Prevent overheating with Intel CPUs
    services.thermald.enable = true;

    # Laptop power and battery settings
    # TODO: See if I could make this work again,
    services.power-profiles-daemon.enable = false;
    services.tlp = {
        enable = true;
        settings = {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 100;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 20;

            #Optional helps save long term battery health
            START_CHARGE_THRESH_BAT1 = 50; # 50 and below it starts to charge
            STOP_CHARGE_THRESH_BAT1 = 80; # 80 and above it stops charging
        };
    };

    # home-manager.users.orsell.home.file = {
    #     "battery_warn.sh" = { source = ./battery_warn.sh; executable = true; };
    # };

    # systemd.timers."battery-warn" = {
    #     wantedBy = [ "timers.target" ];
    #     timerConfig = {
    #         OnBootSec = "5";
    #         OnUnitActiveSec = "5";
    #         Unit = "battery-warn.service";
    #     };
    # };

    # systemd.services."battery-warn" = {
    #     script = "~/battery_warn.sh";
    #     serviceConfig = {
    #         Type = "oneshot";
    #         User = "orsell";
    #     };
    # };

    # Enable cron service
    # services.cron = {
    #     enable = true;
    #     systemCronJobs = [
    #         "* * * * * orsell ~/battery_warn.sh"
    #     ];
    # };
}