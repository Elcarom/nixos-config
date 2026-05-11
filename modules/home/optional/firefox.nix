{
  pkgs,
  config,
  ...
}:

{
  programs.firefox = {
    enable = true;

    configPath =
      "${config.xdg.configHome}/mozilla/firefox";

    policies = {
      DisableTelemetry = true;
      DisablePocket = true;

      OfferToSaveLogins = false;

      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
      };
    };
  };
}
