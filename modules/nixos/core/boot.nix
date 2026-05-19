{
  ...
}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices.cryptroot = {
    device = "/dev/disk/by-partlabel/disk-main-luks";
    crypttabExtraOpts = [
      "tpm-device=auto"
    ];
  };

}
