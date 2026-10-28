;;; init.el --- Bootstrap packages and load config.org -*- lexical-binding: t; -*-

;; Keep Customize's generated settings out of this (repo-tracked) file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)

;; Package archives
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu"   . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

;; use-package is built in since Emacs 29; install missing packages by default
(require 'use-package)
(setq use-package-always-ensure t)

;; Everything else lives in config.org. It's a symlink into the nixos repo;
;; open it through the link (not the git-controlled target) so config.el is
;; tangled next to it in ~/.emacs.d instead of inside the repo.
(let ((vc-follow-symlinks nil))
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

;;; init.el ends here
