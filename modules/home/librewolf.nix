{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;
    nativeMessagingHosts.packages = [pkgs.firefoxpwa];
  };
}



