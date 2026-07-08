{profile, pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf.override {
      nativeMessagingHosts = with pkgs; [
        pkgs.firefoxpwa
      ];
      hasMozSystemDirPatch = true;
    };
  };
}
