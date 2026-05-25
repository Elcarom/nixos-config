{
  description = "Elcarom NixOS configuration";

  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url =
        "github:nix-community/home-manager";

      inputs.nixpkgs.follows =
        "nixpkgs";
    };

    disko = {
      url =
        "github:nix-community/disko";

      inputs.nixpkgs.follows =
        "nixpkgs";
    };

    nixos-hardware.url =
      "github:NixOS/nixos-hardware";

    nur = {
      url =
        "github:nix-community/NUR";

      inputs.nixpkgs.follows =
        "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
    nixos-hardware,
    nur,
    ...
  }:
  let
    systems = [
      "x86_64-linux"
    ];

    forAllSystems =
      nixpkgs.lib.genAttrs systems;

    mkPkgs = system:
      import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };

        overlays = [
          nur.overlays.default
        ];
      };
  in
  {
    formatter = forAllSystems (
      system:
      (mkPkgs system).nixfmt-rfc-style
    );

    nixosConfigurations.dsk-nos102 =
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        pkgs =
          mkPkgs "x86_64-linux";

        specialArgs = {
          inherit self;

          hardwareModules =
            nixos-hardware.nixosModules;
        };

        modules = [
          ./hosts/dsk-nos102/default.nix

          home-manager.nixosModules.home-manager

          disko.nixosModules.default
        ];
      };
  };
}
