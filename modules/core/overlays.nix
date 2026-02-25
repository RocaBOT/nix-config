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

      # Build picosvg without tests temporarily (tests broken until #493376
      # is propagated to unstable)
      pythonPackagesExtensions =
        prev.pythonPackagesExtensions
        ++ [
          (python-final: python-prev: {
            picosvg = python-prev.picosvg.overridePythonAttrs (oldAttrs: {
              doCheck = false;
            });
          })
        ];
    })
  ];
}
