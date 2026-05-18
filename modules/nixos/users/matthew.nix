{
  pkgs,
  ...
}:

{
  users.users.matthew = {
    isNormalUser = true;
    hashedPassword = "$6$cKRN/IfoXGs4.xe6$dm7RVQRyIt5TlpRBFK4geFar8Kvk2aUUxjsNNPedAXT0Tp1KpXniBpK12CfvZHTR.03uYgL8fjqPdR6K0VmAH1";

    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];

    shell = pkgs.fish;
  };
}
