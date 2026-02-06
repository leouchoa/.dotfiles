#!/usr/bin/env bash

set -euo pipefail

img="${1:-}"

# NeoMutt may pass a quoted filename from mailcap. Strip matching wrapper quotes.
while [[ ${#img} -ge 2 ]]; do
  first="${img:0:1}"
  last="${img: -1}"
  if { [[ "${first}" == "'" ]] || [[ "${first}" == "\"" ]]; } && [[ "${last}" == "${first}" ]]; then
    img="${img:1:${#img}-2}"
  else
    break
  fi
done

if [[ -z "${img}" || ! -f "${img}" ]]; then
  echo "mutt image viewer: file not found." >&2
  exit 1
fi

if command -v chafa >/dev/null 2>&1; then
  cols="${COLUMNS:-120}"
  rows="${LINES:-40}"
  # Force text-symbol output; protocol autodetect can emit Kitty/Sixel escape
  # sequences that don't render correctly inside NeoMutt/tmux.
  chafa --animate=off --format symbols --size "${cols}x${rows}" "${img}"
  exit 0
fi

if command -v viu >/dev/null 2>&1; then
  viu -w "${COLUMNS:-120}" "${img}"
  exit 0
fi

if command -v open >/dev/null 2>&1; then
  open "${img}"
  echo "Opened image in system viewer: ${img}"
  exit 0
fi

if command -v xdg-open >/dev/null 2>&1; then
  xdg-open "${img}" >/dev/null 2>&1 &
  echo "Opened image in system viewer: ${img}"
  exit 0
fi

echo "No image viewer found. Install chafa for in-terminal preview." >&2
exit 1
