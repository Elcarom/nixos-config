{
  writeShellScriptBin,
  lib,
  coreutils,
  curl,
  jq,
  git,
  nix,
  moreutils,
  gnugrep,
}:

let
  path = lib.makeBinPath [
    coreutils
    curl
    jq
    moreutils
    git
    nix
    gnugrep
  ];
in

writeShellScriptBin "update-proton-cachyos" ''
  set -euo pipefail

  PATH=${path}

  srcJson=pkgs/proton-cachyos/versions.json

  localBase=$(jq -r .base < "$srcJson")
  localRelease=$(jq -r .release < "$srcJson")

  latestVer=$(
    curl -s \
      'https://api.github.com/repos/CachyOS/proton-cachyos/releases/latest' \
      | jq -r '.tag_name'
  )

  latestBase=$(echo "$latestVer" | grep -Po '(?<=cachyos-)[0-9.]+')
  latestRelease=$(echo "$latestVer" | grep -Po '(?<=-)[0-9]{8}(?=-slr)')

  if [ "$localBase" = "$latestBase" ] \
    && [ "$localRelease" = "$latestRelease" ]; then
    echo "Already up to date"
    exit 0
  fi

  url="https://cdn77.cachyos.org/repo/x86_64/cachyos/proton-cachyos-slr-1%3A$latestBase.$latestRelease-1-x86_64.pkg.tar.zst"

  hash=$(
    nix-prefetch-url \
      --name proton-cachyos-slr.pkg.tar.zst \
      "$url"
  )

  sriHash=$(
    nix hash to-sri \
      --type sha256 \
      "$hash"
  )

  jq \
    --arg base "$latestBase" \
    --arg release "$latestRelease" \
    --arg hash "$sriHash" \
    '.base = $base | .release = $release | .hash = $hash' \
    "$srcJson" \
    | sponge "$srcJson"

  git add "$srcJson"

  git commit -m \
    "proton-cachyos: $localBase-$localRelease -> $latestBase-$latestRelease"
''
