(add-to-list 'load-path "~/emacs/")
(add-to-list 'load-path "~/emacs/elegant")
(load "custom-file")
(require 'elegance)
(require 'sanity)

;; emacs-client start
;;(setq default-frame-alist '((cursor-color . "#FF00CD")))
(defun my/focus-new-client-frame ()
  (select-frame-set-input-focus (selected-frame)))
(add-hook 'server-after-make-frame-hook #'my/focus-new-client-frame)
(setq inhibit-x-resources 't)
(elegance-misterioso)
;;(add-to-list 'default-frame-alist '(font . "Roboto Mono-13"))
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
(show-paren-mode 1)
(delete-selection-mode 1)
(global-set-key (kbd "M-o") 'other-window)
(setq overlay-arrow-string "") ;;arrow line in proof general
;; emacs startup end

;; use `command` as `meta` in macOS.
(setq mac-command-modifier 'meta)
;; mac end

;; emacs custom files locations
(setq backup-directory-alist `(("." . "~/.saves")))
(setq custom-file "~/emacs/custom-file.el")
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

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  )

;; theme 
;;(load-theme 'misterioso)
(use-package jetbrains-darcula-theme
  :ensure t
  :config
  ;;(load-theme 'jetbrains-darcula t)
  )
;; theme end

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

;; smartparens
(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode))
;; smartparens end

;; json start
(use-package json-mode
  :ensure t)
;; json end

;; ocaml begin
(and (require 'cl-lib)
      (use-package tuareg
        :ensure t
        :config
        (add-hook 'tuareg-mode-hook #'electric-pair-local-mode)
        ;; (add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
        (setq auto-mode-alist
              (append '(("\\.ml[ily]?$" . tuareg-mode)
                        ("\\.topml$" . tuareg-mode))
                      auto-mode-alist)))
      
      (use-package merlin
        :ensure t
        :config
        (add-hook 'tuareg-mode-hook #'merlin-mode)
        (add-hook 'merlin-mode-hook #'company-mode)
        (setq merlin-error-after-save nil)
	(use-package flycheck-ocaml
	  :ensure t
	  :config
	  (flycheck-ocaml-setup)
	  (add-hook 'tuareg-mode-hook #'merlin-mode))
	)
      
      ;; utop configuration

      (use-package utop
        :ensure t
        :config
        (autoload 'utop-minor-mode "utop" "Minor mode for utop" t)
        (add-hook 'tuareg-mode-hook 'utop-minor-mode)
        ))

      ;;display type auto
      (use-package merlin-eldoc
       :ensure t
       :hook ((reason-mode tuareg-mode caml-mode) . merlin-eldoc-setup))
;; ocaml end

;;coq start
(use-package proof-general
  :ensure t
  :config
  (use-package company-coq
    :ensure t
    :config
    (add-hook 'coq-mod-hook #'company-coq-mod)))
;; coq end

;; projectile start
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-x p" . projectile-command-map)
              ;; ("C-p p" . projectile-command-map)
              ))
;; projectile end

;;selectrum start
(use-package selectrum
  :ensure t
  :init
  (selectrum-mode +1)
  :config
  (use-package selectrum-prescient
    :ensure t
    :init
    (selectrum-prescient-mode +1)
    (prescient-persist-mode +1)))
;;selectrum end


