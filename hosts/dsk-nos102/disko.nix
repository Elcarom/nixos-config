{
  ...
}:

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";

        content = {
          type = "gpt";

          partitions = {
            ESP = {
              priority = 1;
              size = "1G";
              type = "EF00";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            luks = {
              size = "100%";

              content = {
                type = "luks";
                name = "cryptroot";

                content = {
                  type = "btrfs";

                  extraArgs = [ "-f" ];

                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";

                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };

                    "@home" = {
                      mountpoint = "/home";

                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };

                    "@nix" = {
                      mountpoint = "/nix";

                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };

                    "@persist" = {
                      mountpoint = "/persist";

                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };

                    "@log" = {
                      mountpoint = "/var/log";

                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };

                    "@swap" = {
                      mountpoint = "/swap";

                      mountOptions = [
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
