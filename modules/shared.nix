{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  documentation = {
    nixos.enable = false;
    man.generateCaches = false;
  };
  system.stateVersion = "24.11";
  networking.networkmanager.enable = true;
}
