{profile, ...}: {
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf.override {
      nativeMessagingHosts = with pkgs; [
        ...
      ];
      hasMozSystemDirPatch = true;
    };
  };
}
