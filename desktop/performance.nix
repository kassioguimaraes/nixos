{ config, pkgs, lib, ... }:
# CachyOS-style latency and gaming tweaks, mirrored from linux-cachyos and
# CachyOS-Settings (https://github.com/CachyOS/CachyOS-Settings).
{
  # CachyOS kernel (BORE scheduler, 1000Hz, CachyOS patches) built for
  # x86-64-v3, which the i5-12400F supports. Comes from the nix-cachyos-kernel
  # overlay set up in flake.nix.
  boot.kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;

  nix.settings = {
    substituters = [ "https://cache.lantian.pub/lantian" ];
    trusted-public-keys = [ "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ=" ];
  };

  # sched-ext scheduler as a separate boot entry, to compare against BORE.
  specialisation.scx-lavd.configuration = {
    services.scx = {
      enable = true;
      scheduler = "scx_lavd";
      extraArgs = [ "--performance" ];
    };
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 150; # CachyOS raises it from 100 to 150 once zram is up
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 3;
    "vm.page-cluster" = 0;
    "kernel.nmi_watchdog" = 0;
    "net.core.netdev_max_backlog" = 4096;
    "fs.file-max" = 2097152;
    # Not in CachyOS-Settings: stops the kernel from throttling games that
    # trigger split locks (SteamOS does the same).
    "kernel.split_lock_mitigate" = 0;
  };

  # zram first, the encrypted swap partition only once zram is full.
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 100;
  };
  boot.kernelParams = [ "zswap.enabled=0" ];

  systemd.tmpfiles.rules = [
    "w! /sys/kernel/mm/transparent_hugepage/defrag - - - - defer+madvise"
    "w! /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none - - - - 409"
  ];

  services.udev.extraRules = ''
    # I/O schedulers
    ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", \
      ATTR{queue/scheduler}="bfq"
    ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", \
      ATTR{queue/scheduler}="mq-deadline"
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", \
      ATTR{queue/scheduler}="kyber"

    # SATA link power management
    ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", \
      ATTR{link_power_management_supported}=="1", \
      ATTR{link_power_management_policy}=="*", \
      ATTR{link_power_management_policy}="max_performance"

    # Cap dirty page cache on the HDD and USB disks so sync/umount don't stall
    ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="sd[a-z]*", \
      ATTR{queue/rotational}=="1", ATTR{bdi/strict_limit}="1", ATTR{bdi/max_bytes}="268435456"
    ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", ENV{ID_BUS}=="usb", \
      ATTR{bdi/strict_limit}="1", ATTR{bdi/max_bytes}="16777216"
  '';

  boot.blacklistedKernelModules = [ "iTCO_wdt" "wdat_wdt" ];

  boot.extraModprobeConfig = ''
    options nvidia NVreg_InitializeSystemMemoryAllocations=0
    options snd_hda_intel power_save=0
  '';

  systemd.settings.Manager.DefaultLimitNOFILE = "2048:2097152";

  # Rule-based process priorities. GameMode stays for the CPU governor, but its
  # renice/ioprio are turned off so the two don't fight.
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
  programs.gamemode.settings.general = {
    renice = 0;
    ioprio = "off";
  };
}
