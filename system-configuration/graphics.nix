#* System Graphics Systems, Both Intel and Nvidia, along with OpenGL and PRIME configuration.
{ config, lib, pkgs, ... }:
{
  boot.kernelParams = [
    #? These flags are used to enable backlight control when the dGPU is working in hybrid mode
    "i915.enable_dpcd_backlight=1"
    "nvidia.NVreg_EnableBacklightHandler=0"
    "nvidia.NVReg_RegistryDwords=EnableBrightnessControl=0"
  ];

  environment.systemPackages = with pkgs; [
    nvitop # Nvidia Btop styled process viewer
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  #? Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver    # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver    # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libva-vdpau-driver
      libvdpau-va-gl
      mesa
      nvidia-vaapi-driver
      nv-codec-headers-12
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      mesa
      libvdpau-va-gl
    ];
  };

  #? Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  #? Enable access to nvidia from containers (Docker, Podman)
  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia = {

    #? Modesetting is required.
    modesetting.enable = lib.mkDefault true;

    #? Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    #? Enable this if you have graphical corruption issues or application crashes after waking
    #? up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    #? of just the bare essentials.
    powerManagement.enable = true;

    #? Fine-grained power management. Turns off GPU when not in use.
    #? Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    #? Dynamic Boost. It is a technology found in NVIDIA Max-Q design laptops with RTX GPUs.
    #? It intelligently and automatically shifts power between
    #? the CPU and GPU in real-time based on the workload of your game or application.
    dynamicBoost.enable = true;

    #? Use the NVidia open source kernel module (not to be confused with the
    #? independent third-party "nouveau" open source driver).
    #? Support is limited to the Turing and later architectures. Full list of
    #? supported GPUs is at:
    #? https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    #? Only available from driver 515.43.04+
    open = true;

    #? Enable the Nvidia settings menu,
	  #? accessible via `nvidia-settings`.
    nvidiaSettings = true;

    #? Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    #? Nvidia Optimus PRIME. It is a technology developed by Nvidia to optimize
    #? the power consumption and performance of laptops equipped with their GPUs.
    #? It seamlessly switches between the integrated graphics,
    #? usually from Intel, for lightweight tasks to save power,
    #? and the discrete Nvidia GPU for performance-intensive tasks.
    prime = {
      offload = {
  			enable = true;
  			enableOffloadCmd = true;
  		};

      intelBusId = "PCI:0:2:0";
		  nvidiaBusId = "PCI:01:0:0";
    };
  };
}
