{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    wget
    curl
    tree
    fastfetch
  ];
}
