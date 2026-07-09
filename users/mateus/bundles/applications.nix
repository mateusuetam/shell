{ config, lib, pkgs, ... }:

{
options.my.applications.enable =
lib.mkEnableOption "Bundle de aplicações gráficas";

config = lib.mkIf config.my.applications.enable {

users.users.mateus.packages = with pkgs; [
gimp
mpv
];
};
}
