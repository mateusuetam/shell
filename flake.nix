{
description = "Flake de configuração do NixOS";

inputs = {
nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
};

outputs = { nixpkgs, ... }@inputs: {
nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
system = "x86_64-linux";
modules = [
./configurations/configuration.nix
];
};
};
}
