;;; lsp.el --- Language Server Protocol configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Configures LSP-mode, UI enhancements, and Company-mode for auto-completion.
;; Supports PHP, TypeScript, JavaScript, HTML, CSS, C and Janet.

;;; Code:

(use-package lsp-mode
  :ensure t
  :init
  ;; Set prefix for lsp-command-keymap
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; Languages
         (php-mode . lsp)
         (typescript-ts-mode . lsp)
         (js-ts-mode . lsp)
         (html-mode . lsp)
         (css-mode . lsp)
         (c-mode . lsp)
         (janet-ts-mode . lsp)
         ;; UI/Helper integrations
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  ;; Performance and UI
  (setq lsp-headerline-breadcrumb-enable t
        lsp-enable-on-type-formatting t
        lsp-idle-delay 0.5
        lsp-lens-enable t)
  
  ;; LSP Formatting on save
  (add-hook 'before-save-hook #'lsp-format-buffer nil t))

;; LSP UI elements
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-border "white"
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-peek-enable t))

;; Auto-completion popup
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t
        company-selection-wrap-around t))

;; Better integration with completion frameworks
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

;; Tree-view for symbols and errors
(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)

;; Flycheck for better error highlighting than Flymake
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Language support
(use-package janet-ts-mode
  :vc (:url "https://github.com/sogaiu/janet-ts-mode"
       :rev :newest))

(provide 'lsp)
;;; lsp.el ends here
