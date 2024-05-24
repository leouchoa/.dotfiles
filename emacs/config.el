(use-package evil
  :ensure t
  :config
  (evil-mode 1)
)

(use-package keychain-environment
  :if (string-equal system-type "darwin")
  :ensure t
  :config
  (keychain-refresh-environment)
  )

(use-package sql
  :hook
  (
   ;; trunca linhas e retorna ao buffer no qual são escritas as queries
   (sql-interactive-mode . (lambda ()
                             (visual-line-mode -1)
                             (toggle-truncate-lines t)
                             ;; (other-window -1)
                             ))
   ;; https://www.gnu.org/software/emacs/manual/html_node/eintr/Indent-Tabs-Mode.html
   (sql-mode             . (lambda()
                             (setq indent-tabs-mode nil)
                             (toggle-truncate-lines t)
                             ))
   )
  :bind
  ("C-c s c" . sql-connect)
  )
;; M-x whitespace-mode para verificar misturas de TAB e SPC.
;; C-x h M-x untabify para corrigir o problema

;; adota caminhos de executáveis do shell-path
(use-package exec-path-from-shell
  :ensure t
  :init
  (exec-path-from-shell-initialize)
  )
