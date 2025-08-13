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
    ./power-managment.nix
  ];

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
  hardware.nvidia = {
    open = false;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };

}
