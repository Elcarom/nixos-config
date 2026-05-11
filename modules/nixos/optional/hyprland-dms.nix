{
  dms,
  ...
}:

{
  imports = [
    dms.nixosModules.dank-material-shell
  ];

  programs.hyprland.enable = true;

  programs.dank-material-shell.enable = true;
}
