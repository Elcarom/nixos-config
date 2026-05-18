#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <host>"
  exit 1
fi

HOST="$1"

if [[ ! -d "hosts/$HOST" ]]; then
  echo "Host does not exist: $HOST"
  exit 1
fi

echo "Installing host: $HOST"

echo
echo "Available disks:"

mapfile -t DISKS < <(
  lsblk -d -n -o NAME,SIZE,MODEL \
    | grep -E 'sd|nvme'
)

for i in "${!DISKS[@]}"; do
  printf "%d) %s\n" "$((i + 1))" "${DISKS[$i]}"
done

echo
read -rp "Select disk number: " DISK_INDEX

DISK_LINE="${DISKS[$((DISK_INDEX - 1))]}"

DISK_NAME=$(echo "$DISK_LINE" | awk '{print $1}')

DISK="/dev/$DISK_NAME"

echo
echo "Selected disk: $DISK"

echo
echo "Checking disk safety..."

if mount | grep -q "^$DISK"; then
  echo "ERROR: selected disk appears to be mounted."
  echo "Refusing to continue."
  exit 1
fi

ROOT_SOURCE=$(findmnt -n -o SOURCE /)

if [[ "$ROOT_SOURCE" == "$DISK"* ]]; then
  echo "ERROR: selected disk contains the currently running system."
  echo "Refusing to continue."
  exit 1
fi

echo "Disk safety checks passed."

echo
read -rp "Type CONTINUE to continue: " CONFIRM

if [[ "$CONFIRM" != "CONTINUE" ]]; then
  echo "Aborted."
  exit 1
fi

echo
echo "Running Disko..."

sudo "$(which nix)" run github:nix-community/disko -- \
  --mode destroy,format,mount \
  "hosts/$HOST/disko.nix" \
  --argstr disk "$DISK"

echo
echo "Installing NixOS..."

sudo nixos-install \
  --flake ".#$HOST" \
  --no-root-password

