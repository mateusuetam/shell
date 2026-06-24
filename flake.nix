{
description = "Flake do Home-Manager";

inputs = {
nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
home-manager = {
url = "github:nix-community/home-manager";
inputs.nixpkgs.follows = "nixpkgs";
};
};

outputs = { nixpkgs, home-manager, ... }@inputs: {
nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
system = "x86_64-linux";
modules = [
./configurations/configuration.nix
home-manager.nixosModules.home-manager
];
};
};
}
