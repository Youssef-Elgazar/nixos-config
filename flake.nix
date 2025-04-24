{
  description = "Joe's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.joe = { pkgs, ... }: {
              home.username = "joe";
              home.homeDirectory = "/home/joe";
              programs.home-manager.enable = true;
              home.packages = with pkgs; [
                # General
        pkgs.brave
        pkgs.spotify
        pkgs.bitwarden-desktop
        pkgs.alacritty
        pkgs.vscode
        pkgs.vesktop

	# Web Dev
        pkgs.nodejs_22
        pkgs.bun
        pkgs.postman
              ];
              home.stateVersion = "24.11";
            };
          }
        ];
      };
    };
  };
}
