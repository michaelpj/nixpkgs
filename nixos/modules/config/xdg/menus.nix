{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    xdg.menus.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install files to support the XDG Desktop Menus specification.
      '';
    };
  };

  config = mkIf config.xdg.menus.enable {
    environment.pathsToLink = [ 
      "/share/applications"
      "/share/applications-merged"
      "/share/desktop-directories"
      "/share/menus"
    ];
  };

}
