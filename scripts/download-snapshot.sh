#!/usr/bin/env bash
# download-snapshot.sh — fetch a Lux network snapshot from release assets.
#
# Usage:
#   scripts/download-snapshot.sh <network>
#
# Networks: mainnet, testnet, pq-final
#
# Reads manifest.json, downloads the matching asset into ./<network>/,
# and verifies the sha256.

set -euo pipefail

if [ "${1:-}" = "" ]; then
  echo "usage: $0 <mainnet|testnet|pq-final>" >&2
  exit 2
fi

network="$1"
root="$(cd "$(dirname "$0")/.." && pwd)"
manifest="$root/manifest.json"

if [ ! -f "$manifest" ]; then
  echo "manifest.json not found at $manifest" >&2
  exit 1
fi

entry="$(jq --arg n "$network" '.snapshots[] | select(.network == $n)' "$manifest")"
if [ -z "$entry" ]; then
  echo "no snapshot for network=$network in manifest" >&2
  exit 1
fi

name="$(echo "$entry" | jq -r '.name')"
url="$(echo "$entry" | jq -r '.url')"
want="$(echo "$entry" | jq -r '.sha256')"

dest_dir="$root/$network"
mkdir -p "$dest_dir"
dest="$dest_dir/$name"

echo "downloading $url"
curl -fL --retry 5 --retry-delay 2 -o "$dest" "$url"

if command -v sha256sum >/dev/null 2>&1; then
  got="$(sha256sum "$dest" | awk '{print $1}')"
else
  got="$(shasum -a 256 "$dest" | awk '{print $1}')"
fi

if [ "$got" != "$want" ]; then
  echo "sha256 mismatch for $dest: got $got want $want" >&2
  exit 1
fi

echo "ok: $dest ($got)"
