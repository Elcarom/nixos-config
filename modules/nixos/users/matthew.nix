{
  pkgs,
  ...
}:

{
  users.users.matthew = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    shell = pkgs.fish;
  };
}
