{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  cc3dsfsPkg = inputs.cc3dsfs.packages.${system}.default;
in {
  # Install the Noctalia package
  home.packages = [
    cc3dsfsPkg
  ];

  # Make the service available
  config = {services.udev.package = [cc3dsfsPkg];};
}
