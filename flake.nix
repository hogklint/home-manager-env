{
  description = "Home Manager configuration of hogklint";

  inputs = {
    # Specify the source of Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager input
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # The Charm NUR input for installing Crush
    charm-nur = {
      url = "github:charmbracelet/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { self, nixpkgs, home-manager, charm-nur, nixgl, ... }:
    let
      system = "x86_64-linux"; # Standard for Ubuntu (Intel/AMD)
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ nixgl.overlay ];
      };
    in {
      homeConfigurations."hogklint" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Pass inputs to modules so you can use 'charm-nur' in home.nix
          extraSpecialArgs = { inherit charm-nur; };

          modules = [ ./home.nix charm-nur.homeModules.crush ];
        };
    };
}
