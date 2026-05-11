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
      "docker"
    ];

    shell = pkgs.fish;
  };
}
