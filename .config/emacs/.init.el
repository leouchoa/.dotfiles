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
