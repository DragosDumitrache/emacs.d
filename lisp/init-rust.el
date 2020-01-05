;;; init-rust.el --- Support for the Rust language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'rust-mode)
  (when (maybe-require-package 'racer)
    (add-hook 'rust-mode-hook #'racer-mode))
  (when (maybe-require-package 'company)
    (add-hook 'racer-mode-hook #'company-mode)))

(when (maybe-require-package 'flycheck-rust)
  (after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

;; (use-package flycheck
;;   :hook (prog-mode . flycheck-mode))

;; (use-package company
;;   :hook (prog-mode . company-mode)
;;   :config (setq company-tooltip-align-annotations t)
;;   (setq company-minimum-prefix-length 1))

;; (use-package lsp-mode
;;   :commands lsp
;;   :config (require 'lsp-clients)
;;   :ensure t)

;; (use-package cargo
;;   :ensure t
;;   :diminish cargo-minor-mode
;;   :hook (rust-mode . cargo-minor-mode))

;; (use-package toml-mode
;;   :ensure t)

;; (use-package lsp-ui
;;   :ensure t)

;; (use-package rust-mode
;;   :hook (rust-mode . lsp))

;; ;; Add keybindings for interacting with Cargo
;; (use-package cargo
;;   :hook (rust-mode . cargo-minor-mode))

;; (use-package racer
;;   :hook (rust-mode . racer-mode))
;; (use-package flycheck-rust
;;   :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; (when (maybe-require-package 'rust-mode)
;;   (when (maybe-require-package 'racer)
;;     (add-hook 'rust-mode-hook #'racer-mode))
;;   (when (maybe-require-package 'company)
;;     (add-hook 'racer-mode-hook #'company-mode)))

;; (when (maybe-require-package 'flycheck-rust)
;;   (after-load 'rust-mode
;;     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

;; ;; ;; (use-package rustic
;; ;;   :ensure t)
;; (setq rust-format-on-save t)
;; (global-set-key (kbd "s-b") 'lsp-find-definition)
;; ;; (add-hook 'rust-mode-hook #'racer-mode)
;; ;; (add-hook 'racer-mode-hook #'eldoc-mode)
;; (add-hook 'racer-mode-hook #'company-mode)

;; (require 'rust-mode)
;; (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
;; (setq company-tooltip-align-annotations t)

(use-package lsp-mode
  :hook (rust-mode . lsp)
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;; optionally if you want to use debugger
(use-package dap-mode
  :ensure t)

(use-package dap-rust
  :ensure t)

(provide 'init-rust)
;;; init-rust.el ends here
