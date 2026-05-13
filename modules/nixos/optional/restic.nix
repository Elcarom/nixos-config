{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    restic
  ];

  fileSystems."/srv/nfs/backups" = {
    device = "192.168.2.100:/mnt/user/backups";

    fsType = "nfs";

    options = [
      "nfsvers=4.2"
      "x-systemd.automount"
      "noauto"
      "_netdev"
    ];
  };
}
