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
        "io.gitlab.librewolf-community" # Librewolf
        "eu.betterbird.Betterbird" # Betterbird
        "org.keepassxc.KeePassXC" # KeePassXC
        "io.freetubeapp.FreeTube" # FreeTube youtube frontend
        "com.vysp3r.ProtonPlus" # Wine/Proton variants manager
        "io.github.randovania.Randovania" # Randomizer for metroid games, amongst others
      ];

      # Optional: Automatically update Flatpaks when you run nixos-rebuild switch
      update.onActivation = true;
    };
  };
}
