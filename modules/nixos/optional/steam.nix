{
  pkgs,
  ...
}:

{
  programs.steam = {
    enable = true;

    extraCompatPackages = with pkgs; [
      nur.repos.mio.proton-cachyos
    ];
  };
}
