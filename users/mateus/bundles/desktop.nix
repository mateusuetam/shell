{ config, lib, pkgs, ... }:

{
options.my.desktop.enable =
lib.mkEnableOption "Bundle de ambiente desktop";

config = lib.mkIf config.my.desktop.enable {

xdg.portal.enable = true;

fonts.packages = with pkgs; [
noto-fonts
noto-fonts-cjk-sans
noto-fonts-color-emoji
];

programs = {
bash = {
enable = true;
interactiveShellInit = ''
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
'';
};
git.enable = true;
niri.enable = true;
};

users.users.mateus.packages = with pkgs; [
alacritty
bibata-cursors
tree
unzip
zip
xwayland-satellite
];
};
}
