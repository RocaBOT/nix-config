{
  description = "Homura's config - based on ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    stylix.url = "github:nix-community/stylix";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Checking nixvim to see if it's better
    nixvim = {
      url = "github:nix-community/nixvim";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cc3dsfs = {
      url = "github:RocaBOT/cc3dsfs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";

    # nixpkgs-patch-librewolf-152-0 = {
    #   url = "https://github.com/NixOS/nixpkgs/commit/4fb676193ca9cc8662c2cb87f7e4339360472b18.diff?full_index=1";
    #   flake = false;
    # };
  };

  outputs = {
    nixpkgs,
    nixpkgs-patcher,
    home-manager,
    nixvim,
    nix-flatpak,
    alejandra,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    host = "merihim";
    profile = "amd";
    username = "homura";

    # Deduplicate nixosConfigurations while preserving the top-level 'profile'
    mkNixosConfig = gpuProfile:
      nixpkgs-patcher.lib.nixosSystem {
        inherit system;
        nixpkgsPatcher.nixpkgs = nixpkgs;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit profile; # keep using the let-bound profile for modules/scripts
        };
        nixpkgsPatcher.inputs = inputs;
        modules = [
          ./modules/core/overlays.nix
          ./profiles/${gpuProfile}
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
  in {
    nixosConfigurations = {
      amd = mkNixosConfig "amd";
      nvidia = mkNixosConfig "nvidia";
      nvidia-laptop = mkNixosConfig "nvidia-laptop";
      amd-nvidia-hybrid = mkNixosConfig "amd-nvidia-hybrid";
      intel = mkNixosConfig "intel";
      vm = mkNixosConfig "vm";
    };

    formatter.x86_64-linux = inputs.alejandra.packages.x86_64-linux.default;
  };
}
