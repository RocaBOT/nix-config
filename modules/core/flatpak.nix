{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    configPackages = [pkgs.hyprland];
  };
  services = {
    flatpak = {
      enable = true;

      # List the Flatpak applications you want to install
      # Use the official Flatpak application ID (e.g., from flathub.org)
      # Examples:
      packages = [
        "com.github.tchx84.Flatseal" #Manage flatpak permissions - should always have this
        #"com.rtosta.zapzap"              # WhatsApp client
        #"io.github.flattool.Warehouse"   # Manage flatpaks, clean data, remove flatpaks and deps
        #"it.mijorus.gearlever"           # Manage and support AppImages
        #"io.github.dvlv.boxbuddyrs"      #  Manage distroboxes
        #"de.schmidhuberj.tubefeeder"     #watch YT videos

        # Add other Flatpak IDs here, e.g., "org.mozilla.firefox"
        "eu.betterbird.Betterbird" # Betterbird
        "com.vysp3r.ProtonPlus" # Wine/Proton variants manager
        "io.github.randovania.Randovania" # Randomizer for metroid games, amongst others
        # "com.discordapp.Discord" # official Discord client - sometimes broken because this is trash
      ];

      # Optional: Automatically update Flatpaks when you run nixos-rebuild switch
      update.onActivation = true;
    };
  };
}
