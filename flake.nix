{
  description = "Elcarom NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url =
      "github:NixOS/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
    nixos-hardware,
    ...
  }:
  let
    systems = [
      "x86_64-linux"
    ];

    forAllSystems =
      nixpkgs.lib.genAttrs systems;
  in
  {
    overlays.default = final: prev: {
      proton-cachyos =
        final.callPackage
          ./pkgs/proton-cachyos { };
    };

    packages = forAllSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        proton-cachyos =
          pkgs.callPackage
            ./pkgs/proton-cachyos { };

        update-proton-cachyos =
          pkgs.callPackage
            ./pkgs/proton-cachyos/update.nix { };
      });

    formatter = forAllSystems (system:
      nixpkgs.legacyPackages.${system}.nixfmt-rfc-style
    );

    nixosConfigurations.dsk-nos102 =
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

    specialArgs = {
      inherit self;

      hardwareModules =
        nixos-hardware.nixosModules;
    };

        modules = [
          ./hosts/dsk-nos102/default.nix

          home-manager.nixosModules.home-manager
          disko.nixosModules.default

          {
            nixpkgs.overlays = [
              self.overlays.default
            ];
          }
        ];
      };
  };
}
