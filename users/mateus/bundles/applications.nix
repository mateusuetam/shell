{ config, lib, pkgs, ... }:

{
options.my.applications = {
opensource.enable = lib.mkEnableOption "Bundle de aplicações gráficas";
proprietary.enable = lib.mkEnableOption "Bundle de aplicações gráficas proprietárias";
};

config = lib.mkMerge [

(lib.mkIf config.my.applications.opensource.enable {

users.users.mateus.packages = with pkgs; [
gimp
mpv
];
})

(lib.mkIf config.my.applications.proprietary.enable {

nixpkgs.config.allowUnfreePredicate = pkg:
builtins.elem (lib.getName pkg) [
"discord"
"spotify"
];

users.users.mateus.packages = with pkgs; [
discord
spotify
];
})

];
}
