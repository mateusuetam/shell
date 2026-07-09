{ config, lib, pkgs, ... }:

{
imports = [
./bundles/applications.nix
./bundles/browser.nix
./bundles/course.nix
./bundles/neovim.nix
./bundles/desktop.nix
./bundles/dotfiles.nix
../../quickshell/shell.nix
];

options.my.users.mateus = {
enable = lib.mkEnableOption "Habilitar minhas configurações de usuário";
};

config = lib.mkIf config.my.users.mateus.enable {

users.users.mateus = {
isNormalUser = true;
extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
};

my = {
applications = {
opensource.enable = true;
proprietary.enable = true;
};
browser.enable = true;
course.enable = true;
neovim.enable = true;
desktop.enable = true;
dotfiles = {
enable = true;
homeDir = "/home/mateus";
owner = "mateus:users";
};
quickshell = {
shell.enable = true;
devmode.enable = true;
};
};
};
}
