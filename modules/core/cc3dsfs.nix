{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  cc3dsfsPkg = inputs.cc3dsfs.packages.${system}.default;
in {
  config = {
    # Install the cc3dsfs package
    environment.systemPackages = [
      cc3dsfsPkg
    ];

    # Make the service available
    services.udev.packages = [cc3dsfsPkg];
  };
}
