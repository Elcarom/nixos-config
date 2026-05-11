{
  pkgs,
  ...
}:

{
  users.mutableUsers = false;

  users.allowNoPasswordLogin = true;

  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;
}
