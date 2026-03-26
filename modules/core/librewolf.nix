# SDDM is a display manager for X11 and Wayland
{
  pkgs,
  config,
  lib,
  host,
  ...
}: let
  package = pkgs.librewolf.override {
    nativeMessagingHosts = with pkgs; [
        firefoxpwa
    ];
    hasMozSystemDirPatch = true;
  };
in {
  librewolf = {
      package = pkgs.librewolf;
      enable = true;
  };
}