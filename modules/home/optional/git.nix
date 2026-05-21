{
  pkgs,
  ...
}:

{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
    };

    signing = {
      signByDefault = true;
      key = "~/.ssh/id_ed25519.pub";
    };

    settings = {
      gpg.format = "ssh";

      url."git@github.com:".insteadOf =
        "https://github.com/";
    };
  };

  home.packages = with pkgs; [
    git
  ];
}
