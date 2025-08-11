{ ... }:
{
  imports = [
    ./programs
    ./shared.nix
    ./power-managment.nix
    ./user.nix
    ./packages.nix
  ];
}
