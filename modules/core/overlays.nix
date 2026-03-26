{...}: {
  nixpkgs.overlays = [
    (_final: prev: {
      # Build tumbler without EPUB thumbnailer (libgepub) to avoid webkitgtk
      xfce =
        prev.xfce
        // {
          tumbler = prev.xfce.tumbler.overrideAttrs (old: {
            buildInputs = prev.lib.remove prev.libgepub old.buildInputs;
          });
        };
    })
  ];
}
