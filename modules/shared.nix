{
  pkgs,
  config,
  lib,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  networking.hosts = {
    "10.0.0.1" = [ "chatgpt.com" ];
  };

  boot.loader = {
    systemd-boot.enable = true;
    timeout = 5;
    efi.canTouchEfiVariables = true;
  };

  documentation = {
    nixos.enable = false;
    man.generateCaches = false;
  };
  system.stateVersion = "24.11";
  networking.networkmanager.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  time.timeZone = "Europe/Helsinki";
  programs.dconf.profiles.potat369 = {
    databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
          "org/gtk/settings/file-chooser" = {
            sort-directories-first = "true";
            startup-mode = "cwd";
          };
        };
      }
    ];
  };
}
