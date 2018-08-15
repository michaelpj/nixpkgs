{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    xdg.mime.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install files to support the XDG Shared Mime Info specification.
      '';
    };
  };

  config = mkIf config.xdg.mime.enable {
    environment.pathsToLink = [ "/share/mime" ];
  };

}
