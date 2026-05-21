{
  config,
  pkgs,
  ...
}:

{
  users.users.matthew = {
    isNormalUser = true;

    hashedPassword =
      "$6$mgao3Qxd9W5eIa0R$KQO8oLFDjTViaTv2BDDaZ5/NGQDqe7A2s4opv5s.S7KaS8NdfBGKqjm/nxgtQeLhmCFbTMBMua6Uvz1zTEOIx0";

    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];

    shell = pkgs.fish;
  };
}
