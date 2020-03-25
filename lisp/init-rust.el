;;; init-rust.el --- Support for the Rust language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; init-rust.el --- Support for the Rust language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; (when (maybe-require-package 'rust-mode)
;;   (when (maybe-require-package 'racer)
;;     (add-hook 'rust-mode-hook #'racer-mode))
;;   (when (maybe-require-package 'company)
;;     (add-hook 'racer-mode-hook #'company-mode)))

;; (when (maybe-require-package 'flycheck-rust)
;;   (after-load 'rust-mode
;;     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

;; (use-package racer
;;   :requires rust-mode

;;   :init (setq racer-rust-src-path
;;               (concat (string-trim
;;                        (shell-command-to-string "rustc --print sysroot"))
;;                       "/lib/rustlib/src/rust/src"))

;;   :config
;;   (add-hook 'rust-mode-hook #'racer-mode)
;;   (add-hook 'racer-mode-hook #'eldoc-mode)
;;   (add-hook 'racer-mode-hook #'company-mode))

;; (use-package toml-mode)

;; (use-package rust-mode
;;   :hook (rust-mode . lsp))

(require-package 'rust-mode)

(use-package dap-mode
  :requires  (rust-mode))

;; (require 'dap-lldb)
(require 'dap-gdb-lldb)
;; {
;; "type": "lldb",
;; "request": "launch",
;; "name": "Debug executable 'advent_of_code'",
;; "cargo": {
;; "args": [
;;          "build",
;;          "--bin=advent_of_code",
;;          "--package=advent_of_code"
;;          ],
;; "filter": {
;; "name": "advent_of_code",
;; "kind": "bin"
;; }
;; },
;; "args": ["1:1"],
;; "cwd": "${workspaceFolder}"
;; },

;; (dap-register-debug-template "My Runner"
;;                              (list :type "lldb"
;;                                    :request "launch"
;;                                    :args "1:1"
;;                                    :cargo:
;;                                    :mainClass "com.domain.AppRunner"
;;                                    :env '(("DEV" . "1"))))

;; Map TAB key to completions.
(local-set-key (kbd "TAB") 'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

(use-package company :ensure t
  :config
  (setq company-idle-delay 0.2)
  (add-hook 'racer-mode-hook
    (lambda ()
      (setq-local company-tooltip-align-annotations t))))



;; Flycheck-Begin. On the fly syntax checking for multiple programming languages.
;; Enable Flycheck in buffers with supported languages.
(use-package flycheck :ensure t)
(use-package flycheck-rust :ensure t)
(use-package rust-mode :ensure t
  :config
  (setq rust-format-on-save t))

(use-package racer :ensure t
  :config
  (progn
        (add-hook 'rust-mode-hook #'racer-mode) ;; Activate racer in rust buffers.
        (add-hook 'racer-mode-hook #'eldoc-mode) ;; Shows signature of current function in minibuffer.
        ;; Rust completions with Company and Racer.
        (add-hook 'racer-mode-hook #'company-mode)))

(use-package company :ensure t
  :config
  (setq company-idle-delay 0.2)
  (add-hook 'racer-mode-hook
    (lambda ()
      (setq-local company-tooltip-align-annotations t))))

;; Enable Cargo minor mode allows us to do cargo commands
;; rust-mode and toml-mode
(use-package cargo :ensure t
  :config
  (progn
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
        (add-hook 'toml-mode-hook 'cargo-minor-mode)))

(add-hook 'after-init-hook #'global-flycheck-mode)

;; Flycheck Rust support.
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
;; Flycheck-End.

;; Path to rust source.
(when (equal system-type 'gnu/linux)
  (setq racer-rust-src-path (concat (getenv "HOME") "/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")))
(when (equal system-type 'darwin)
  (setq racer-rust-src-path (concat (getenv "HOME") "/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src")))
;; Racer bin path.
(setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))

;; Map TAB key to completions.
;; (local-set-key (kbd "TAB") 'company-indent-or-complete-common)
;; (setq company-tooltip-align-annotations t)


(provide 'init-rust)
;;; init-rust.el ends here
