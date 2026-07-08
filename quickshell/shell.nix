{ config, lib, pkgs, ... }:

{
options.my.quickshell = {
enable = lib.mkEnableOption "Enable Quickshell UI";
development.enable = lib.mkEnableOption "Ferramentas de Desenvolvimento para a Quickshell";
};

config = lib.mkMerge [
(lib.mkIf config.my.quickshell.enable {

environment.systemPackages = with pkgs; [
brightnessctl
cliphist
gammastep
libnotify
monaspace
quickshell
wl-clipboard
];

systemd.user.services.quickshell = {
description = "Quickshell Wayland UI";
partOf = [ "graphical-session.target" ];
after = [ "graphical-session.target" ];
wantedBy = [ "graphical-session.target" ];

environment = {
QT_LOGGING_RULES = "quickshell.dbus.properties=false";
};

serviceConfig = {
ExecStart = "${pkgs.quickshell}/bin/quickshell";
Restart = "on-failure";
KillMode = "process";
};
};
})

(lib.mkIf config.my.quickshell.development.enable {
environment.systemPackages = with pkgs; [
qtcreator
qt6.qtwayland

(symlinkJoin {
name = "qmllint-wrapped";
paths = [ qt6.qtdeclarative ];
nativeBuildInputs = [ makeWrapper ];
postBuild = ''
wrapProgram $out/bin/qmllint \
--add-flags "-I ${pkgs.qt6.qtdeclarative}/lib/qt-6/qml" \
--add-flags "-I ${pkgs.qt6.qtbase}/lib/qt-6/qml" \
--add-flags "-I ${pkgs.quickshell}/lib/qt-6/qml"
'';
})
];
})
];
}
