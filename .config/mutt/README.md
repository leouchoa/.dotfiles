# NeoMutt + Gmail

This setup uses NeoMutt's native IMAP/SMTP support with a Gmail App Password.
HTML parts are rendered with `lynx`, and image attachments are previewed in-terminal with `chafa` when available.

## 1) Gmail prerequisites

1. Enable 2-Step Verification in your Google account.
2. Create an App Password for `Mail`.
3. Keep IMAP enabled in Gmail settings.

## 2) Local credentials (not tracked)

Create `~/.config/mutt/.env` from the template:

```bash
cp ~/.config/mutt/.env.example ~/.config/mutt/.env
```

Then edit values:

```bash
export MUTT_GMAIL_ADDRESS="your-address@gmail.com"
export MUTT_GMAIL_APP_PASSWORD="your-16-char-app-password"
export MUTT_GMAIL_REALNAME="Your Name"
```

Reload shell:

```bash
source ~/.config/zsh/.zshrc
```

## 3) Run

```bash
neomutt
```

`~/.neomuttrc` and `~/.muttrc` both source `~/.config/mutt/muttrc`, and the shell alias maps `mutt` -> `neomutt`.

## Image Display Notes

- Best terminal preview: install `chafa` (`brew install chafa` on macOS).
- Fallback behavior:
- If `chafa`/`viu` is unavailable, NeoMutt opens image attachments in system viewer (`open`/`xdg-open`).
- NeoMutt auto-renders allowed MIME parts because `implicit_autoview` is enabled in config.
