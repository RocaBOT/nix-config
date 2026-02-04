{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  cc3dsfsPkg = inputs.librepods.packages.${system}.default;
in {
  config = {
    # Install the librepods package
    environment.systemPackages = [
      librepodsPkg
    ];
  };
}
