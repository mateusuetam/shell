{ pkgs, ... }:

{
imports = [
./settings/alacritty.nix
./settings/bash.nix
./settings/neovim.nix
./settings/niri.nix
./settings/preferences.nix
../../quickshell/shell.nix
];

my.quickshell.enable = true;
my.quickshell.development.enable = true;

home.packages = with pkgs; [
discord
gimp
spotify
tree
unzip
zip
];

programs = {
alacritty.enable = true;
bash.enable = true;
firefox.enable = true;
git.enable = true;
mpv.enable = true;
neovim.enable = true;
};

home.pointerCursor = {
gtk.enable = true;
package = pkgs.bibata-cursors;
name = "Bibata-Modern-Classic";
size = 24;
};

home.stateVersion = "26.05";
}
