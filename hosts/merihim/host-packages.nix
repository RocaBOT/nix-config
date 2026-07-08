{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pokefinder # pokemon rng assistant
    firefoxpwa # pwa for firefox (and in this case, librewolf)
    calibre # ebook reader
    uxplay # Open Source AirPlay interface
    ferium # Minecraft Mod Manager
    prismlauncher # Minecraft Launcher
    openjdk25 # Java
  ];
  # Add host specific flatpaks here
  services = {
    flatpak = {
      packages = [
      ];
    };
  };
}
