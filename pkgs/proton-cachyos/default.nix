{
  lib,
  stdenv,
  fetchurl,
  zstd,
}:

let
  versions = builtins.fromJSON (
    builtins.readFile ./versions.json
  );
in

stdenv.mkDerivation rec {
  pname = "proton-cachyos";
  version = "${versions.base}-${versions.release}";

  src = fetchurl {
    name = "proton-cachyos-slr.pkg.tar.zst";

    url =
      "https://cdn77.cachyos.org/repo/x86_64/cachyos/"
      + "proton-cachyos-slr-1%3A${versions.base}.${versions.release}-1-x86_64.pkg.tar.zst";

    hash = versions.hash;
  };

  nativeBuildInputs = [ zstd ];

  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    tar -I zstd -xf $src

    mkdir -p $out/share/steam/compatibilitytools.d

    cp -r usr/share/steam/compatibilitytools.d/* \
      $out/share/steam/compatibilitytools.d/

    runHook postInstall
  '';

  meta = with lib; {
    description = "CachyOS Proton compatibility layer";
    homepage = "https://github.com/CachyOS/proton-cachyos";
    license = licenses.bsd3;
    platforms = [ "x86_64-linux" ];
  };
}
