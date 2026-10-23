#!/bin/sh
set -eu

timezone=${TZ:-Europe/Rome}
case "$timezone" in
  ""|/*|..|../*|*/..|*"/../"*)
    echo "Invalid TZ value: $timezone" >&2
    exit 1
    ;;
esac

if [ ! -f "/usr/share/zoneinfo/$timezone" ]; then
  echo "Unknown TZ value: $timezone" >&2
  exit 1
fi

echo "Timezone validated: $timezone"
