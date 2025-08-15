{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable {
        system = system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit unstable inputs; };
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./hosts/laptop
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.potat369 = import ./modules/home.nix;
          }
        ];
      };
    };
}
