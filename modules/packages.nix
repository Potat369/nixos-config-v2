{
  pkgs,
  config,
  lib,
  unstable,
  ...
}:
let
  user = config.users.users.potat369;
in
{
  environment.systemPackages = with pkgs; [
    btop
    wezterm
    ripgrep
    discord
    prismlauncher
    git
    gh
    microsoft-edge
    rofi
    hypridle

    # Language Tools
    nixd
    nixfmt-rfc-style
  ];

  programs = {
    steam.enable = true;
    noisetorch.enable = true;
    direnv = {
      enable = true;
      enableFishIntegration = true;
      silent = true;
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        if not uwsm check is-active; and uwsm check may-start
            exec uwsm start hyprland-uwsm.desktop
        end

        set -U fish_greeting
        set -g fish_color_autosuggestion "#625e5a"
      '';
      promptInit = ''
        function fish_prompt
          printf '%s%s%s> ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
        end
      '';
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      repo = "https://github.com/Potat369/nvim-config";
      user = user;
    };
    idea = {
      enable = true;
      patchedMinecraftEntry = true;
      package = unstable.jetbrains.idea-ultimate;
    };
    java.enable = true;
    rider = {
      enable = true;
      patchedTMLEntry = true;
      package = unstable.jetbrains.rider;
    };
    hyprland = {
      enable = true;
      withUWSM = true;
    };
  };

  services.flatpak = {
    enable = true;
    packages = [
      {
        appId = "org.vinegarhq.Sober";
        origin = "flathub";
      }
    ];
  };
}
