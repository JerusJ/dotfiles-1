;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Additional Syntax
(package! systemd)

;; Org Mode
(package! org-jira)
(package! org-super-agenda)
(use-package! ox-html
  :defer 3
  :after org
  :custom
  (org-html-checkbox-type 'unicode))
(use-package! ox-md
  :defer 3
  :after org)
(use-package! ox-jira
  :defer 3
  :after org)
(use-package! ox-confluence
  :defer 3
  :after org)

;; Python
(use-package! python-mode
  :ensure nil
  :custom
  (python-shell-interpreter "python3"))
