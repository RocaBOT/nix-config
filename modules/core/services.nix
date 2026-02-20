{profile, ...}: {
  # Services to start
  services = {
    upower.enable = true; # noctalia shell battery
    libinput.enable = true; # Input Handling
    fstrim.enable = true; # SSD Optimizer
    gvfs.enable = true; # For Mounting USB & More
    power-profiles-daemon.enable = true;
    openssh = {
      enable = true; # Enable SSH
      settings = {
        PermitRootLogin = "no"; # Prevent root from SSH login
        PasswordAuthentication = true; #Users can SSH using kb and password
        KbdInteractiveAuthentication = true;
      };
      ports = [22];
    };
    blueman.enable = true; # Bluetooth Support
    tumbler.enable = true; # Image/video preview
    gnome.gnome-keyring.enable = true;

    smartd = {
      enable =
        if profile == "vm"
        then false
        else true;
      autodetect = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire-pulse."60-echo-cancel" = {
        context.modules = [
          {
            name = "libpipewire-module-echo-cancel";
            args = {
              monitor.mode = true;
              capture.props = {
                node.passive = true;
              };
              source.props = {
                node.name = "virtual_mic";
                node.description = "Echo-cancelled source";
              };
              aec.args = {
                webrtc.extended_filter = false;
              };
            };
          }
        ];
      };
      extraConfig.pipewire."91-null-sinks" = {
        "context.objects" = [
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Simult. Output";
              "node.description" = "Passthrough to all output devices";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
            };
          }
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Game Output";
              "node.description" = "Aggregates game sound";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
            };
          }
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Music Output";
              "node.description" = "Aggregates music";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
            };
          }
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Fake Output";
              "node.description" = "Sink for OBS monitoring when needed";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
            };
          }
        ];
      };
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 256;
        };
      };
      extraConfig.pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "256/48000";
              pulse.default.req = "256/48000";
              pulse.max.req = "256/48000";
              pulse.min.quantum = "256/48000";
              pulse.max.quantum = "256/48000";
            };
          }
        ];
      };
    };
  };
}
