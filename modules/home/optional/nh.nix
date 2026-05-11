{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    nh
  ];

  programs.fish.shellAliases = {
    rebuild =
      "nh os switch ~/Projects/nixos-config";

    update =
      "nix flake update ~/Projects/nixos-config";
  };
}
