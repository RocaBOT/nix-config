{
  host,
  config,
  pkgs,
  lib,
  ...
}: let
  vars = import ../../../hosts/${host}/variables.nix;
  extraMonitorSettings = vars.extraMonitorSettings or "";
  animChoice = vars.animChoice or "";
  keyboardLayout = vars.keyboardLayout or "us";
  keyboardVariant = vars.keyboardVariant or "";
  stylixImage = vars.stylixImage or null;
  toLua = lib.generators.toLua { };

  # Treat only known US-based variants as implying layout = "us".
  usVariants = ["dvorak" "colemak" "workman" "intl" "us-intl" "altgr-intl"];
  normalizeUSVariant = v:
    if v == "us-intl"
    then "intl"
    else v;

  # If layout itself is a US variant (e.g., "dvorak", "us-intl"), normalize it
  layoutFromLayout = keyboardLayout;
  #  if builtins.elem keyboardLayout usVariants
  #  then "us"
  #  else keyboardLayout;
  variantFromLayout =
    if builtins.elem keyboardLayout usVariants
    then normalizeUSVariant keyboardLayout
    else "";

  # If the provided variant is a US variant, force layout to us; otherwise keep layout
  layoutFromVariant = layoutFromLayout;
  #  if builtins.elem keyboardVariant usVariants
  #  then "us"
  #  else layoutFromLayout;
  variantFinal =
    if builtins.elem keyboardVariant usVariants
    then normalizeUSVariant keyboardVariant
    else if variantFromLayout != ""
    then variantFromLayout
    else keyboardVariant;

  hyprKbLayout = layoutFromVariant;
  hyprKbVariant = variantFinal;

  bindSettings = (import ./binds.nix { }).wayland.windowManager.hyprland.settings or { };
  binddEntries = bindSettings.bindd or [ ];
  bindmEntries = bindSettings.bindm or [ ];

  envEntries = ((import ./env.nix { }).wayland.windowManager.hyprland.settings.env or [ ]);
  execOnceEntries = ((import ./exec-once.nix { }).wayland.windowManager.hyprland.settings.exec-once or [ ]);
  animationSettings = ((import animChoice { }).wayland.windowManager.hyprland.settings.animations or { });
  windowRulesHyprlang = ((import ./windowrules.nix { }).wayland.windowManager.hyprland.extraConfig or "");

  monitorLines = builtins.filter (line: line != "") (map lib.strings.trim (lib.splitString "\n" extraMonitorSettings));

  nixLuaConfig = {
    modifier = "SUPER";
    keyboard = {
      layout = hyprKbLayout;
      variant =  hyprKbVariant;
    };
    theme = {
      base01 = config.lib.stylix.colors.base01;
      base08 = config.lib.stylix.colors.base08;
      base0C = config.lib.stylix.colors.base0C;
    };
    env = envEntries;
    execOnce = execOnceEntries;
    bindd = binddEntries;
    bindm = bindmEntries;
    monitorLines = monitorLines;
    animation = {
      enabled = animationSettings.enabled or true;
      bezier = animationSettings.bezier or [ ];
      animation = animationSettings.animation or [ ];
    };
    windowRulesHyprlang = windowRulesHyprlang;
  };
in {

  home.packages = with pkgs; [
    awww
    grim
    slurp
    wl-clipboard
    swappy
    ydotool
    hyprpolkitagent
    hyprshot
    hyprpicker
    #hyprland-qtutils # needed for banners and ANR messages
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  # Place Files Inside Home Directory
  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../../wallpapers;
      recursive = true;
    };
    ".face.icon".source = ./face.jpg;
    ".config/face.jpg".source = ./face.jpg;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = pkgs.hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = ["--all"];
    };
    xwayland = {
      enable = true;
    };
    extraConfig = ''
      require("extra.vars")
      require("extra.settings")
      require("extra.monitors")
      require("extra.env")
      require("extra.animations")
      require("extra.window_rules")
      require("extra.startup")
      require("extra.keybinds")
    '';
    extraLuaFiles = {
      "extra.vars" = {
        autoLoad = false;
        content = ''
          EXTRA = ${toLua nixLuaConfig}
        '';
      };
      "extra.settings" = {
        autoLoad = false;
        content = ./lua/settings.lua;
      };
      "extra.monitors" = {
        autoLoad = false;
        content = ./lua/monitors.lua;
      };
      "extra.env" = {
        autoLoad = false;
        content = ./lua/env.lua;
      };
      "extra.animations" = {
        autoLoad = false;
        content = ./lua/animations.lua;
      };
      "extra.window_rules" = {
        autoLoad = false;
        content = ./lua/window_rules.lua;
      };
      "extra.startup" = {
        autoLoad = false;
        content = ./lua/startup.lua;
      };
      "extra.keybinds" = {
        autoLoad = false;
        content = ./lua/keybinds.lua;
      };
    };
  };
}
