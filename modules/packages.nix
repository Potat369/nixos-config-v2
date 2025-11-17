{
  pkgs,
  config,
  lib,
  unstable,
  unstable-small,
  inputs,
  ...
}:
let
  user = config.users.users.potat369;
in
{
  environment.systemPackages = with pkgs; [
    arduino
    wezterm
    discord
    prismlauncher
    libreoffice-qt6-fresh
    android-studio
    microsoft-edge
    aseprite
    dunst
    wl-clipboard
    (pkgs.symlinkJoin {
      name = "vscode";
      buildInputs = with pkgs; [
        makeWrapper
        fna3d
      ];
      paths = [ pkgs.vscode ];
      postBuild = ''
        wrapProgram $out/bin/code \
          --set LD_LIBRARY_PATH ${pkgs.lib.makeLibraryPath [ pkgs.fna3d ]}
      '';
    })

    # Hyprland
    hypridle
    hyprshot

    # Terminal Tools
    unzip
    brightnessctl
    ddcutil
    btop
    bluetuith
    git
    ripgrep
    fzf

    # Language Tools
    nil
    nixfmt-rfc-style
    lua-language-server
    stylua
    (
      with dotnetCorePackages;
      combinePackages [
        dotnet_9.sdk
        dotnet_8.sdk
      ]
    )
  ];

  programs = {
    obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override {
        cudaSupport = true;
      };
      plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
    };
    droidcam.enable = true;
    steam.enable = true;
    noisetorch.enable = true;
    direnv = {
      enable = true;
      enableFishIntegration = true;
      silent = true;
    };
    fish = {
      enable = true;
      interactiveShellInit = # fish
        ''
          if not uwsm check is-active; and uwsm check may-start
              exec uwsm start hyprland-uwsm.desktop
          end

          set -U fish_greeting
          set -g fish_color_autosuggestion "#625e5a"

          function ls --wraps=ls
            LC_COLLATE=C command ls -AF --group-directories-first --color=never -w 80 $argv
          end
        '';
      promptInit = # fish
        ''
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
      enable = false;
      patchedTMLEntry = true;
      package = unstable-small.jetbrains.rider;
    };
    hyprland = {
      enable = true;
      withUWSM = true;
    };
  };

  services = {
    flatpak = {
      enable = true;
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
      packages = [
        {
          appId = "org.vinegarhq.Sober";
          origin = "flathub";
        }
      ];
    };
  };
}
