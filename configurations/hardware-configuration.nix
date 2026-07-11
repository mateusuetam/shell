{ config, lib, pkgs, modulesPath, ... }:

{
imports =
[ (modulesPath + "/installer/scan/not-detected.nix")
];

boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
boot.initrd.kernelModules = [ ];
boot.kernelModules = [ ];
boot.extraModulePackages = [ ];

fileSystems."/" =
{ device = "/dev/disk/by-uuid/d8c93870-f36d-4ba8-9982-4c29e2f58123";
fsType = "ext4";
};

fileSystems."/boot" =
{ device = "/dev/disk/by-uuid/0F0D-D8DA";
fsType = "vfat";
options = [ "fmask=0077" "dmask=0077" ];
};

swapDevices = [ ];

nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
