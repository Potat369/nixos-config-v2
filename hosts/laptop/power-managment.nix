{ pkgs, ... }:
{
  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = false;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
        scaling_max_freq = 3500000;
      };
    };
  };
}
