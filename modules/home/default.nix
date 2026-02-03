{host, ...}: let
  vars = import ../../hosts/${host}/variables.nix;
  inherit
    (vars)
    barChoice
    waybarChoice
    ;
  # Select bar module based on barChoice
  barModule =
    if barChoice == "noctalia"
    then ./noctalia.nix
    else waybarChoice;
in {
  imports = [
    ./bash.nix
    ./bashrc-personal.nix
    ./overview.nix
    ./python.nix
    ./cli/bat.nix
    ./cli/btop.nix
    ./cli/bottom.nix
    ./cli/cava.nix
    ./emoji.nix
    ./eza.nix
    ./fastfetch
    ./cli/fzf.nix
    ./cli/gh.nix
    ./cli/git.nix
    ./gtk.nix
    ./cli/htop.nix
    ./hyprland
    ./terminals/kitty.nix
    ./cli/lazygit.nix
    ./obs-studio.nix
    ./editors/nixvim.nix
    ./editors/nano.nix
    ./rofi
    ./qt.nix
    ./scripts
    ./stylix.nix
    ./swappy.nix
    ./swaync.nix
    ./tealdeer.nix
    ./virtmanager.nix
    barModule
    ./wlogout
    ./xdg.nix
    ./yazi
    ./zoxide.nix
    ./zsh
    ./cc3dsfs.nix
  ];
}
