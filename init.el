(add-to-list 'load-path "~/emacs/")
(load "custom-file")

;; emacs-client start
(setq default-frame-alist '((cursor-color . "#FF00CD")))
(defun my/focus-new-client-frame ()
  (select-frame-set-input-focus (selected-frame)))
(add-hook 'server-after-make-frame-hook #'my/focus-new-client-frame)
(setq inhibit-x-resources 't)
;; emacs-client end


;; emacs startup
(setq-default inhibit-startup-screen t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'fundamental-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(line-number-mode t)
;; emacs startup end

;; use `command` as `meta` in macOS.
(setq mac-command-modifier 'meta)
;; mac end

;; emacs custom files locations
(setq backup-directory-alist `(("." . "~/.saves")))
(setq custom-file "/home/rakesh/emacs/custom-file.el")
;; emacs custom files end

;; require and initialize package
(require 'package)
(package-initialize)

;; add melpa to archives
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; melpa end

;; install use-package (after melpa)
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
;; install use-package end

;; use this theme 
(load-theme 'misterioso)

;; autocomplete company
(use-package company
    :ensure t
    :bind (:map company-active-map
		("C-n" . company-select-next)
		("C-p" . company-select-previous))
    :config
    (setq company-idle-delay 0.3)
    (global-company-mode t))
;; company end


;; magit start
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))
;; magit-end
