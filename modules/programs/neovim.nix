{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.programs.neovim;
in
{
  options.programs.neovim = {
    repo = lib.mkOption {
      type = lib.types.str;
    };
    user = lib.mkOption {
      type = lib.types.attrs;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ (lib.mkIf (cfg.repo != "") pkgs.git) ];
    system.activationScripts.setupNeovim = (
      if cfg.repo == "" then
        ""
      else
        let
          configDir = "${cfg.user.home}/.config/nvim";
        in
        ''
          if [ ! -d ${configDir} ]; then
             echo "Pulling Neovim config..."
             ${pkgs.git}/bin/git clone ${cfg.repo} ${configDir}
             chown ${cfg.user.name}:users ${configDir}
          else
              echo "Neovim config found..."
          fi
        ''
    );
  };
}
