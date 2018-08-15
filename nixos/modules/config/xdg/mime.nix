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

    environment.extraSetup = ''
      XDG_DATA_DIRS=$out/share ${pkgs.shared-mime-info}/bin/update-mime-database -V $out/share/mime > /dev/null

      ${pkgs.desktop-file-utils}/bin/update-desktop-database $out/share/applications
    '';
  };

}
