{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    xdg.icons.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install files to support the XDG Icon Theme specification.
      '';
    };
  };

  config = mkIf config.xdg.icons.enable {
    environment.pathsToLink = [ 
      "/share/icons" 
      "/share/pixmaps" 
    ];
    
    environment.profileRelativeEnvVars = {
      XCURSOR_PATH = [ "/share/icons" ];
    };
  };

}
