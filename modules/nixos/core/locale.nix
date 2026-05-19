{
  ...
}:

{
  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_GB.UTF-8";

  console.useXkbConfig = true;

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  services.xserver.exportConfiguration = true;

  boot.initrd.systemd.enable = true;

}
