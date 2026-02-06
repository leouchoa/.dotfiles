#!/usr/bin/env bash

set -euo pipefail

DEFAULT_INITIAL=25
DEFAULT_REPEAT=6

is_macos() {
  [[ "$(uname -s)" == "Darwin" ]]
}

usage() {
  cat <<'EOF'
Usage:
  mac_key_repeat.sh status [--short]
  mac_key_repeat.sh apply [--profile balanced|snappy|teleport] [--initial N --repeat N] [--dry-run]
  mac_key_repeat.sh reset [--dry-run]

Profiles:
  balanced  InitialKeyRepeat=20 KeyRepeat=3
  snappy    InitialKeyRepeat=15 KeyRepeat=2
  teleport  InitialKeyRepeat=10 KeyRepeat=1

Notes:
  - Lower values are faster.
  - Log out and back in for system-wide effect after applying.
EOF
}

read_setting() {
  local key="$1"
  defaults read -g "${key}" 2>/dev/null || true
}

require_int() {
  local key="$1"
  local value="$2"
  if [[ ! "${value}" =~ ^[0-9]+$ ]] || (( value < 1 )); then
    printf "ERROR: %s must be a positive integer, got '%s'\n" "${key}" "${value}" >&2
    exit 1
  fi
}

profile_values() {
  local profile="$1"
  case "${profile}" in
    balanced)
      echo "20 3"
      ;;
    snappy)
      echo "15 2"
      ;;
    teleport|fast)
      echo "10 1"
      ;;
    *)
      printf "ERROR: Unknown profile '%s'. Use balanced|snappy|teleport.\n" "${profile}" >&2
      exit 1
      ;;
  esac
}

print_status() {
  local short="${1:-0}"
  if ! is_macos; then
    if (( short )); then
      echo "InitialKeyRepeat=unsupported KeyRepeat=unsupported"
    else
      echo "mac_key_repeat.sh: macOS only (no-op on this OS)."
    fi
    return 0
  fi

  local initial
  local repeat
  initial="$(read_setting InitialKeyRepeat)"
  repeat="$(read_setting KeyRepeat)"

  if (( short )); then
    echo "InitialKeyRepeat=${initial:-default(${DEFAULT_INITIAL})} KeyRepeat=${repeat:-default(${DEFAULT_REPEAT})}"
    return 0
  fi

  echo "macOS key repeat settings:"
  echo "- InitialKeyRepeat: ${initial:-default (${DEFAULT_INITIAL})}"
  echo "- KeyRepeat: ${repeat:-default (${DEFAULT_REPEAT})}"
}

apply_settings() {
  local initial="$1"
  local repeat="$2"
  local dry_run="$3"

  if ! is_macos; then
    echo "mac_key_repeat.sh: macOS only (skipping apply)."
    return 0
  fi

  if (( dry_run )); then
    echo "[dry-run] defaults write -g InitialKeyRepeat -int ${initial}"
    echo "[dry-run] defaults write -g KeyRepeat -int ${repeat}"
    return 0
  fi

  defaults write -g InitialKeyRepeat -int "${initial}"
  defaults write -g KeyRepeat -int "${repeat}"
  echo "Applied macOS key repeat: InitialKeyRepeat=${initial}, KeyRepeat=${repeat}"
  echo "Log out and back in for consistent system-wide behavior."
}

reset_settings() {
  local dry_run="$1"

  if ! is_macos; then
    echo "mac_key_repeat.sh: macOS only (skipping reset)."
    return 0
  fi

  if (( dry_run )); then
    echo "[dry-run] defaults delete -g InitialKeyRepeat"
    echo "[dry-run] defaults delete -g KeyRepeat"
    return 0
  fi

  defaults delete -g InitialKeyRepeat >/dev/null 2>&1 || true
  defaults delete -g KeyRepeat >/dev/null 2>&1 || true
  echo "Reset macOS key repeat overrides to system defaults."
  echo "Log out and back in for consistent system-wide behavior."
}

main() {
  local cmd="${1:-status}"
  shift || true

  local profile="snappy"
  local initial=""
  local repeat=""
  local dry_run=0
  local short=0

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --profile)
        profile="${2:-}"
        shift 2
        ;;
      --initial)
        initial="${2:-}"
        shift 2
        ;;
      --repeat)
        repeat="${2:-}"
        shift 2
        ;;
      --dry-run)
        dry_run=1
        shift
        ;;
      --short)
        short=1
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        printf "ERROR: Unknown argument: %s\n" "$1" >&2
        usage
        exit 1
        ;;
    esac
  done

  case "${cmd}" in
    status)
      print_status "${short}"
      ;;
    apply)
      if [[ -n "${initial}" || -n "${repeat}" ]]; then
        if [[ -z "${initial}" || -z "${repeat}" ]]; then
          echo "ERROR: --initial and --repeat must be provided together." >&2
          exit 1
        fi
      else
        read -r initial repeat <<<"$(profile_values "${profile}")"
      fi
      require_int "InitialKeyRepeat" "${initial}"
      require_int "KeyRepeat" "${repeat}"
      apply_settings "${initial}" "${repeat}" "${dry_run}"
      ;;
    reset)
      reset_settings "${dry_run}"
      ;;
    *)
      printf "ERROR: Unknown command: %s\n" "${cmd}" >&2
      usage
      exit 1
      ;;
  esac
}

main "$@"
