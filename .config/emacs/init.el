(require 'package)
;;(setq package-enable-at-startup nil)
(setq package-archives
      '(
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ;; ("org" . "http://orgmode.org/elpa/")
        ))
(package-initialize)
 
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t)
  )
 
(org-babel-load-file (expand-file-name "~/.config/emacs/config.org"))
(org-babel-load-file (expand-file-name "~/.config/emacs/sql-connector.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
