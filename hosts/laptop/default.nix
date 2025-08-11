{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./../../modules
    ./hardware.nix
  ];
}
