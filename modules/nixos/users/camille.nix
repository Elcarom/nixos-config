{
  pkgs,
  ...
}:

{
  users.users.camille = {
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
    ];

    shell = pkgs.fish;
  };
}
