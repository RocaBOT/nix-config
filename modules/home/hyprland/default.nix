{host, ...}: let
  inherit (import ../../../hosts/${host}/variables.nix) animChoice;
in {
  imports = [
    animChoice
    ./hyprland.nix
    ./binds.nix
    ./env.nix
    ./exec-once.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./pyprland.nix
    ./windowrules.nix
  ];
}
