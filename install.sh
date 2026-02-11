#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="${DOTFILES_DIR}/.config/Brewfile"
TPM_DIR="${HOME}/.config/tmux/plugins/tpm"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"
MAC_KEY_REPEAT_SCRIPT="${DOTFILES_DIR}/.config/custom_scripts/mac_key_repeat.sh"
PREFERRED_POSTGRES_FORMULA="postgresql@18"
POSTGRES_FORMULA_CANDIDATES=("postgresql@18" "postgresql@17" "postgresql@16" "postgresql@15" "postgresql@14" "postgresql")

DRY_RUN=0
DOCTOR_ONLY=0

log() {
  printf "==> %s\n" "$*"
}

warn() {
  printf "WARN: %s\n" "$*" >&2
}

die() {
  printf "ERROR: %s\n" "$*" >&2
  exit 1
}

run() {
  if (( DRY_RUN )); then
    printf "[dry-run] %q" "$1"
    shift
    for arg in "$@"; do
      printf " %q" "$arg"
    done
    printf "\n"
    return 0
  fi
  "$@"
}

ensure_macos() {
  if [[ "$(uname -s)" != "Darwin" ]]; then
    die "This installer is for macOS. On Linux, use manual setup from README.md."
  fi
}

ensure_xcode_cli() {
  if xcode-select -p >/dev/null 2>&1; then
    return
  fi

  log "Xcode Command Line Tools are required. Triggering installer..."
  run xcode-select --install || true
  die "Install Xcode Command Line Tools and run ./install.sh again."
}

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  log "Installing Homebrew..."
  if (( DRY_RUN )); then
    echo "[dry-run] /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    return
  fi

  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

load_brew_env() {
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  if ! command -v brew >/dev/null 2>&1; then
    if (( DRY_RUN || DOCTOR_ONLY )); then
      warn "brew is not installed. Continuing without loading brew environment."
      return
    fi
    die "brew is still unavailable after installation."
  fi
}

ensure_oh_my_zsh() {
  if [[ -d "${HOME}/.oh-my-zsh" ]]; then
    return
  fi

  log "Installing Oh My Zsh..."
  if (( DRY_RUN )); then
    echo "[dry-run] RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
    return
  fi

  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

ensure_git_repo() {
  local repo_url="$1"
  local target_dir="$2"

  if [[ -d "${target_dir}/.git" ]]; then
    log "Updating ${target_dir}..."
    run git -C "${target_dir}" pull --ff-only >/dev/null || warn "Could not fast-forward ${target_dir}; leaving as-is."
    return
  fi

  log "Cloning ${repo_url} -> ${target_dir}"
  run mkdir -p "$(dirname "${target_dir}")"
  run git clone --depth=1 "${repo_url}" "${target_dir}"
}

install_brew_bundle() {
  [[ -f "${BREWFILE}" ]] || die "Missing Brewfile at ${BREWFILE}"
  log "Installing Homebrew dependencies from ${BREWFILE}..."
  run brew bundle --file "${BREWFILE}" --verbose
}

install_ohmyzsh_plugins() {
  run mkdir -p "${ZSH_CUSTOM_DIR}/plugins"
  ensure_git_repo "https://github.com/Aloxaf/fzf-tab" "${ZSH_CUSTOM_DIR}/plugins/fzf-tab"
  ensure_git_repo "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM_DIR}/plugins/zsh-autosuggestions"
}

install_tmux_plugins() {
  ensure_git_repo "https://github.com/tmux-plugins/tpm" "${TPM_DIR}"

  if [[ -x "${TPM_DIR}/bin/install_plugins" ]]; then
    log "Installing tmux plugins via TPM..."
    run "${TPM_DIR}/bin/install_plugins" || warn "TPM plugin install failed; run manually inside tmux with <prefix> + I."
  else
    warn "TPM install script not found at ${TPM_DIR}/bin/install_plugins"
  fi
}

stow_dotfiles() {
  log "Stowing dotfiles..."
  run stow -R -d "${DOTFILES_DIR}" -t "${HOME}" -v .
}

install_gh_dash_if_possible() {
  if (( DRY_RUN )); then
    log "Skipping gh-dash installation check in dry-run mode."
    return
  fi

  if ! command -v gh >/dev/null 2>&1; then
    return
  fi

  if ! gh auth status >/dev/null 2>&1; then
    warn "GitHub CLI is not authenticated. Run 'gh auth login' then 'gh extension install dlvhdr/gh-dash'."
    return
  fi

  if gh extension list 2>/dev/null | grep -q 'dlvhdr/gh-dash'; then
    return
  fi

  log "Installing gh-dash extension..."
  run gh extension install dlvhdr/gh-dash || warn "Could not install gh-dash."
}

resolve_key_repeat_profile() {
  local profile="${MAC_KEY_REPEAT_PROFILE:-snappy}"
  case "${profile}" in
    balanced|snappy|teleport)
      echo "${profile}"
      ;;
    *)
      warn "Invalid MAC_KEY_REPEAT_PROFILE='${profile}'. Falling back to 'snappy'."
      echo "snappy"
      ;;
  esac
}

configure_macos_key_repeat() {
  if [[ "${SKIP_MAC_KEY_REPEAT:-0}" == "1" ]]; then
    log "Skipping macOS key repeat configuration (SKIP_MAC_KEY_REPEAT=1)."
    return
  fi

  if [[ ! -f "${MAC_KEY_REPEAT_SCRIPT}" ]]; then
    warn "Key repeat script not found at ${MAC_KEY_REPEAT_SCRIPT}; skipping."
    return
  fi

  if [[ ! -x "${MAC_KEY_REPEAT_SCRIPT}" ]]; then
    run chmod +x "${MAC_KEY_REPEAT_SCRIPT}"
  fi

  local profile
  profile="$(resolve_key_repeat_profile)"

  log "Applying macOS key repeat profile: ${profile}"
  run "${MAC_KEY_REPEAT_SCRIPT}" apply --profile "${profile}"
}

detect_postgres_formula() {
  local formula
  for formula in "${POSTGRES_FORMULA_CANDIDATES[@]}"; do
    if brew list --versions "${formula}" >/dev/null 2>&1; then
      echo "${formula}"
      return 0
    fi
  done
  return 1
}

run_postflight_checks() {
  local zsh_check
  local issues=0

  if (( DRY_RUN && ! DOCTOR_ONLY )); then
    log "Skipping post-install checks in dry-run mode."
    return 0
  fi

  log "Running post-install checks..."

  if ! command -v brew >/dev/null 2>&1; then
    warn "Homebrew is not installed or not in PATH."
    issues=$((issues + 1))
  fi

  if ! command -v stow >/dev/null 2>&1; then
    warn "stow is not available."
    issues=$((issues + 1))
  fi

  if [[ ! -e "${HOME}/.config/zsh/.zshrc" ]]; then
    warn "Expected ${HOME}/.config/zsh/.zshrc not found. Dotfiles may not be stowed yet."
    issues=$((issues + 1))
  fi

  if [[ ! -d "${ZSH_CUSTOM_DIR}/plugins/fzf-tab" ]]; then
    warn "Oh My Zsh plugin missing: ${ZSH_CUSTOM_DIR}/plugins/fzf-tab"
    issues=$((issues + 1))
  fi

  if [[ ! -d "${ZSH_CUSTOM_DIR}/plugins/zsh-autosuggestions" ]]; then
    warn "Oh My Zsh plugin missing: ${ZSH_CUSTOM_DIR}/plugins/zsh-autosuggestions"
    issues=$((issues + 1))
  fi

  if [[ ! -x "${TPM_DIR}/bin/install_plugins" ]]; then
    warn "TPM is missing or incomplete at ${TPM_DIR}"
    issues=$((issues + 1))
  fi

  if ! command -v fzf >/dev/null 2>&1; then
    warn "fzf is not available."
    issues=$((issues + 1))
  fi

  if [[ ! -x "${HOME}/.local/bin/fclear" ]]; then
    warn "fclear wrapper missing at ${HOME}/.local/bin/fclear"
    issues=$((issues + 1))
  elif ! "${HOME}/.local/bin/fclear" --version >/dev/null 2>&1; then
    warn "fclear is not runnable (check Go installation and ~/.config/fclear)."
    issues=$((issues + 1))
  fi

  local postgres_formula=""
  if ! postgres_formula="$(detect_postgres_formula)"; then
    warn "No Homebrew PostgreSQL formula installed. Preferred: ${PREFERRED_POSTGRES_FORMULA}"
    issues=$((issues + 1))
  else
    local postgres_bin
    postgres_bin="$(brew --prefix "${postgres_formula}" 2>/dev/null || true)/bin/psql"
    if [[ ! -x "${postgres_bin}" ]]; then
      warn "Expected PostgreSQL client not found at ${postgres_bin}"
      issues=$((issues + 1))
    fi

    if [[ "${postgres_formula}" != "${PREFERRED_POSTGRES_FORMULA}" ]]; then
      warn "Detected ${postgres_formula}. Preferred formula for new installs is ${PREFERRED_POSTGRES_FORMULA}."
    fi
  fi

  if ! command -v zsh >/dev/null 2>&1; then
    warn "zsh not found; skipping keybinding checks."
    issues=$((issues + 1))
  else
    # Non-TTY interactive zsh can print zle warnings; we only parse keybinding lines.
    zsh_check="$(zsh -i -c 'bindkey "^R"; bindkey "^I"; bindkey -M viins "^I"' 2>/dev/null || true)"

    if ! grep -q 'fzf-history-widget' <<<"${zsh_check}"; then
      warn "Ctrl-r is not bound to fzf-history-widget. Open a new shell and run: bindkey \"^R\""
      issues=$((issues + 1))
    fi

    if ! grep -q 'fzf-tab-complete' <<<"${zsh_check}"; then
      warn "Tab is not bound to fzf-tab-complete. Open a new shell and run: bindkey \"^I\""
      issues=$((issues + 1))
    fi
  fi

  if [[ -x "${MAC_KEY_REPEAT_SCRIPT}" ]]; then
    local key_repeat_status
    key_repeat_status="$("${MAC_KEY_REPEAT_SCRIPT}" status --short 2>/dev/null || true)"
    if [[ -z "${key_repeat_status}" || "${key_repeat_status}" == *"unsupported"* ]]; then
      warn "Could not read macOS key repeat settings."
      issues=$((issues + 1))
    fi
  else
    warn "Key repeat helper missing or not executable at ${MAC_KEY_REPEAT_SCRIPT}"
    issues=$((issues + 1))
  fi

  if command -v ghostty >/dev/null 2>&1; then
    if ! ghostty +validate-config --config-file "${HOME}/.config/ghostty/config" >/dev/null 2>&1; then
      warn "Ghostty config validation reported a failure (non-fatal check)."
    fi
  else
    warn "ghostty is not installed (non-fatal check)."
  fi

  if (( issues > 0 )); then
    warn "Post-install checks found ${issues} issue(s)."
    return 1
  fi

  log "Post-install checks passed."
  return 0
}

print_next_steps() {
  cat <<'EOF'

Setup completed.

Next steps:
1. Open a new terminal session (or run: source ~/.config/zsh/.zshrc).
2. Authenticate GitHub CLI if needed: gh auth login
3. Install Node default if needed: nvm install 22 && nvm alias default 22
4. Install Python default if needed: pyenv install 3.12 && pyenv global 3.12
5. Start PostgreSQL if needed: brew services start postgresql@18
6. Open Neovim once and let plugins sync: nvim
7. Log out and back in once so key repeat tuning is applied everywhere.
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run)
        DRY_RUN=1
        ;;
      --doctor)
        DOCTOR_ONLY=1
        ;;
      -h|--help)
        cat <<EOF
Usage: ./install.sh [--dry-run] [--doctor]

Idempotent macOS bootstrap for this dotfiles repo.
  --dry-run  Print commands without executing them (install mode only)
  --doctor   Run health checks only (no install actions)

Environment variables:
  MAC_KEY_REPEAT_PROFILE=balanced|snappy|teleport  (default: snappy)
  SKIP_MAC_KEY_REPEAT=1                            (skip key repeat tuning)
EOF
        exit 0
        ;;
      *)
        die "Unknown argument: $1"
        ;;
    esac
    shift
  done

  if (( DOCTOR_ONLY && DRY_RUN )); then
    warn "--dry-run has no effect with --doctor."
  fi
}

main() {
  parse_args "$@"
  ensure_macos

  if (( DOCTOR_ONLY )); then
    load_brew_env
    if run_postflight_checks; then
      printf "\nDoctor checks passed.\n"
      exit 0
    fi
    die "Doctor checks failed. Review warnings above."
  fi

  ensure_xcode_cli
  ensure_homebrew
  load_brew_env
  run brew analytics off || true
  install_brew_bundle
  run brew install stow >/dev/null
  ensure_oh_my_zsh
  install_ohmyzsh_plugins
  stow_dotfiles
  install_tmux_plugins
  install_gh_dash_if_possible
  configure_macos_key_repeat
  run_postflight_checks || warn "Some checks failed. Re-run './install.sh --doctor' after fixing warnings."
  print_next_steps
}

main "$@"
