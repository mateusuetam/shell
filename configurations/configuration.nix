{ config, lib, pkgs, ... }:

{
imports = [
./hardware-configuration.nix
../users/mateus/settings/course.nix
];

boot = {
loader = {
systemd-boot.enable = true;
efi.canTouchEfiVariables = true;
timeout = 1;
};
kernelPackages = pkgs.linuxPackages_latest;
kernelParams = [
"nowatchdog"
"nmi_watchdog=0"
];
blacklistedKernelModules = [
# Controlador SATA AHCI
"ahci" "libahci"
# Dispositivos de entrada legados/Apple
"joydev" "mousedev" "mac_hid"
# Recursos opcionais
"thunderbolt" "bnep" "autofs4"
# Watchdogs de hardware
"sp5100_tco" "iTCO_wdt" "iTCO_vendor_support" "watchdog"
# Protocolos/Sistemas de arquivos obsoletos e driver de teste
"ax25" "netrom" "rose" "adfs" "affs" "befs" "cramfs" "efs" "freevxfs"
"hfs" "hfsplus" "hpfs" "jfs" "minix" "nilfs2" "omfs" "qnx4" "qnx6" "sysv" "vivid"
# Plataformas AMD SOF não utilizadas
"snd_sof_amd_acp70" "snd_sof_amd_acp63" "snd_sof_amd_vangogh" "snd_sof_amd_rembrandt"
];
kernel.sysctl = {
"net.ipv4.conf.all.accept_redirects" = 0;
"net.ipv6.conf.all.accept_redirects" = 0;
"net.ipv4.conf.default.accept_redirects" = 0;
"net.ipv6.conf.default.accept_redirects" = 0;
"net.ipv4.conf.all.accept_source_route" = 0;
"net.ipv6.conf.all.accept_source_route" = 0;
"net.ipv4.conf.default.accept_source_route" = 0;
"net.ipv6.conf.default.accept_source_route" = 0;
"net.ipv4.conf.all.send_redirects" = 0;
"net.ipv4.conf.default.send_redirects" = 0;
"net.ipv4.tcp_syncookies" = 1;
"net.ipv4.tcp_rfc1337" = 1;
"net.ipv4.icmp_echo_ignore_all" = 1;
"kernel.dmesg_restrict" = 1;
"kernel.kptr_restrict" = 2;
};
extraModprobeConfig = ''
options rtw89_pci disable_aspm_l1=y disable_aspm_l1ss=y
options rtw89_core disable_ps_mode=y
'';
};

networking = {
hostName = "pc";
nftables.enable = true;
firewall.enable = true;
networkmanager.enable = true;
modemmanager.enable = false;
};

environment.etc."systemd/system-sleep/rfkill".source =
pkgs.writeShellScript "rfkill-sleep" ''
case "$1" in
pre)
${pkgs.util-linux}/bin/rfkill block all
;;
post)
${pkgs.util-linux}/bin/rfkill unblock all
;;
esac
'';

systemd.services.NetworkManager-wait-online.enable = false;

console = {
keyMap = "br-abnt2";
};
i18n = {
defaultLocale = "pt_BR.UTF-8";
};
time.timeZone = "America/Recife";

nix = {
settings = {
auto-optimise-store = true;
experimental-features = [
"nix-command"
"flakes"
];
};
gc = {
automatic = true;
dates = "weekly";
options = "--delete-older-than 7d";
};
};

hardware = {
bluetooth.enable = true;
};

security.rtkit.enable = true;

services = {
pipewire = {
enable = true;
alsa.enable = true;
alsa.support32Bit = true;
pulse.enable = true;
};
upower = {
enable = true;
percentageLow = 20;
percentageCritical = 15;
percentageAction = 10;
criticalPowerAction = "Suspend";
allowRiskyCriticalPowerAction = true;
};
displayManager.enable = false;
};

xdg.portal.enable = true;

fonts.packages = with pkgs; [
noto-fonts
noto-fonts-cjk-sans
noto-fonts-color-emoji
];

nixpkgs.config.allowUnfree = true;
programs.niri.enable = true;
my.course.enable = true;

users = {
users.mateus = {
isNormalUser = true;
extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
};
};

home-manager = {
useGlobalPkgs = true;
useUserPackages = true;
backupFileExtension = "backup";
users = {
mateus = ../users/mateus/user.nix;
};
};

documentation = {
man.enable = true;
info.enable = false;
doc.enable = false;
nixos.enable = false;
};

system.stateVersion = "26.05";
}
