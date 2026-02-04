{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  librepodsPkg = inputs.librepods.packages.${system}.default;
in {
  config = {
    # Install the librepods package
    environment.systemPackages = [
      librepodsPkg
    ];
  };
}
