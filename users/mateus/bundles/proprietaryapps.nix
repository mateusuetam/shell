{ config, lib, pkgs, ... }:

{
options.my.proprietaryapps.enable =
lib.mkEnableOption "Bundle de aplicações gráficas proprietárias";

config = lib.mkIf config.my.proprietaryapps.enable {

nixpkgs.config.allowUnfree = true;

users.users.mateus.packages = with pkgs; [
discord
spotify
];
};
}
