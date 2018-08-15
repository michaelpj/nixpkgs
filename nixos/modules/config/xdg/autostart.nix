{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    xdg.autostart.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install files to support the XDG Autostart specification.
      '';
    };
  };

  config = mkIf config.xdg.autostart.enable {
    environment.pathsToLink = [ 
      "/etc/xdg/autostart"
    ];
  };

}
