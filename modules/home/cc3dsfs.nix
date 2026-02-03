{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  cc3dsfsPkg = inputs.cc3dsfs.packages.${system}.default;
in {
  # Install the cc3dsfs package
  home.packages = [
    cc3dsfsPkg
  ];
}
