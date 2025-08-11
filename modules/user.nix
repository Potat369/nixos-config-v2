{ pkgs, ... }:
{
  users.users.potat369 = {
    isNormalUser = true;
    description = "Potat369";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
  services.getty.autologinUser = "potat369";
}
