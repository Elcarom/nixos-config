{
  pkgs,
  self,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  fileSystems."/srv/nfs/comfyui" = {
    device = "192.168.2.100:/mnt/user/comfyui";

    fsType = "nfs";

    options = [
      "nfsvers=4.2"
      "x-systemd.automount"
      "noauto"
      "_netdev"
    ];
  };

  systemd.services.comfyui = {
    description = "ComfyUI Docker Compose";

    after = [
      "network-online.target"
      "docker.service"
      "srv-nfs-comfyui.mount"
    ];

    wants = [
      "network-online.target"
      "docker.service"
    ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      WorkingDirectory = "${self}/containers/comfyui";

      ExecStart = "${pkgs.docker-compose}/bin/docker-compose up -d";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose down";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
