function podman_init() {
  if ! command -v podman &> /dev/null; then
    echo "🔌 Podman is not installed. Skipping podman_init."
    return 0
  fi

  if ! podman machine list 2>/dev/null | grep -qE '^podman-machine-default\s+Running'; then
    echo "🚀 Starting Podman machine..."
    podman machine start podman-machine-default >/dev/null
  fi

  local current_conn=$(podman system connection list | awk '/\*/ {print $1}')
  if [[ "$current_conn" != "podman-machine-default" ]]; then
    echo "🔧 Setting default Podman connection..."
    podman system connection default podman-machine-default >/dev/null
  fi
}

