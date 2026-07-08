{
  pkgs,
  host,
  options,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) hostId;
in {
  networking = {
    hostName = "${host}";
    hostId = hostId;
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        8080
        7100
        7000
        7001
        42069
      ];
      allowedUDPPorts = [
        6000
        6001
        7011
        59010
        59011
        42069
      ];
    };
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
