{
  description = "Elcarom NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url =
      "github:NixOS/nixos-hardware";

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    disko,
    nixos-hardware,
    dms,
    ...
  }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.dsk-nos102 =
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit
            self
            agenix
            disko
            nixos-hardware
            dms
            ;

          proton-cachyos = self.packages.${system}.proton-cachyos;
        };

        modules = [
          ./hosts/dsk-nos102/default.nix

          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          disko.nixosModules.disko
        ];
      };

      packages.${system} = {
        proton-cachyos =
          nixpkgs.legacyPackages.${system}.callPackage
            ./pkgs/proton-cachyos { };

        update-proton-cachyos =
          nixpkgs.legacyPackages.${system}.callPackage
            ./pkgs/proton-cachyos/update.nix { };
};
  };
}
