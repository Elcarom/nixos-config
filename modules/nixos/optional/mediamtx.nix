{
  pkgs,
  ...
}:

let
  ffmpegBin = "${pkgs.ffmpeg}/bin/ffmpeg";

  camera =
    "/dev/v4l/by-id/usb-046d_Brio_500_2410LZ53PT98-video-index0";

  rtspBase = "rtsp://127.0.0.1:8554";
in
{
  environment.systemPackages = with pkgs; [
    ffmpeg
  ];

  systemd.services.mediamtx.serviceConfig = {
    SupplementaryGroups = [ "video" ];
  };

  networking.firewall.allowedTCPPorts = [
    8554
  ];

  services.mediamtx = {
    enable = true;

    settings = {
      logLevel = "info";

      rtsp = true;
      rtspAddress = ":8554";

      rtmp = true;
      rtmpAddress = ":1935";

      hls = true;
      hlsAddress = ":8888";

      webrtc = true;
      webrtcAddress = ":8889";

      paths = {
        main = { };
        sub = { };

        cam = {
          runOnInit = ''
            /run/current-system/sw/bin/bash -c '
              sleep 2 &&
              ${ffmpegBin} \
                -y \
                -f v4l2 \
                -input_format mjpeg \
                -video_size 1920x1080 \
                -framerate 30 \
                -i /dev/video0 \
                -filter_complex "[0:v]format=nv12,hwupload_cuda,split=2[v1][v2];[v1]scale_cuda=1920:1080[vmain];[v2]scale_cuda=640:360[vsub]" \
                -map "[vmain]" \
                  -c:v h264_nvenc \
                  -preset p1 \
                  -tune ll \
                  -g 30 \
                  -bf 0 \
                  -b:v 5M \
                  -f rtsp \
                  -rtsp_transport tcp \
                  ${rtspBase}/main \
                -map "[vsub]" \
                  -c:v h264_nvenc \
                  -preset p1 \
                  -tune ll \
                  -g 30 \
                  -bf 0 \
                  -b:v 1M \
                  -f rtsp \
                  -rtsp_transport tcp \
                  ${rtspBase}/sub
            '
          '';
          runOnInitRestart = true;
        };
      };
    };
  };
}
