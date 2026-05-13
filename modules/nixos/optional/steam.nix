{
  proton-cachyos,
  ...
}:

{
  programs.steam = {
    enable = true;

    extraCompatPackages = [
      proton-cachyos
    ];
  };
}
