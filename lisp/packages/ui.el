;;; ui.el --- Packages related to ui -*- lexical-binding: t; -*-
;;; Commentary:
;; Packages and configuration that add ui and eye candy packages

;;; Code:

(use-package eldoc-box
  :ensure t
  :straight t
  :defer t)


(use-package diff-hl
  :defer t
  :straight t
  :ensure t
  :hook
  (find-file . (lambda ()
                 (global-diff-hl-mode)
                 (diff-hl-flydiff-mode)
                 (diff-hl-margin-mode)))
  :custom
  (diff-hl-side 'left)
  (diff-hl-margin-symbols-alist '((insert . "┃")
                                  (delete . "-")
                                  (change . "┃")
                                  (unknown . "┆")
                                  (ignored . "i"))))
(use-package pulsar
  :defer t
  :straight t
  :ensure t
  :hook
  (after-init . pulsar-global-mode)
  :config
  (setq pulsar-pulse t)
  (setq pulsar-delay 0.025)
  (setq pulsar-iterations 10)
  (setq pulsar-face 'evil-ex-lazy-highlight)

  (add-to-list 'pulsar-pulse-functions 'evil-scroll-down)
  (add-to-list 'pulsar-pulse-functions 'flymake-goto-next-error)
  (add-to-list 'pulsar-pulse-functions 'flymake-goto-prev-error)
  (add-to-list 'pulsar-pulse-functions 'evil-yank)
  (add-to-list 'pulsar-pulse-functions 'evil-yank-line)
  (add-to-list 'pulsar-pulse-functions 'evil-delete)
  (add-to-list 'pulsar-pulse-functions 'evil-delete-line)
  (add-to-list 'pulsar-pulse-functions 'evil-jump-item)
  (add-to-list 'pulsar-pulse-functions 'diff-hl-next-hunk)
  (add-to-list 'pulsar-pulse-functions 'diff-hl-previous-hunk))

(use-package doom-modeline
  :ensure t
  :straight t
  :defer t
  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)
  (doom-modeline-project-detection 'project)
  (doom-modeline-buffer-name t)
  (doom-modeline-vcs-max-length 25)
  :config
  (setq doom-modeline-time t)
  (if ek-use-nerd-fonts
      (setq doom-modeline-icon t)
    (setq doom-modeline-icon nil))
  :hook
  (after-init . doom-modeline-mode))

(use-package dashboard
  :straight t
  :config
  ;; Initialize
  (add-hook 'after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'after-init-hook #'dashboard-initialize)

  ;; Set dashboard as startup screen
  (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  (dashboard-setup-startup-hook))

;; Config
(setq dashboard-startup-banner "~/.emacs.d/icons/freedom.png")
(setq dashboard-image-banner-max-height 200)
(setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
(setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
(setq dashboard-center-content t)
(setq dashboard-startupify-list '(dashboard-insert-banner
                                  dashboard-insert-navigator
                                  dashboard-insert-newline
                                  dashboard-insert-init-info
                                  dashboard-insert-items
                                  dashboard-insert-newline
                                  dashboard-insert-footer))
(setq dashboard-items '((recents   . 5)
                        (projects  . 5)
                        (agenda    . 5)))

(use-package treemacs
  :ensure t
  :straight t)

(use-package treemacs-evil
  :ensure t
  :straight t)

(use-package ghostel
  :ensure t)

(use-package evil-ghostel
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode))

(use-package centaur-tabs
  :ensure t
  :demand t
  :init
  (setq centaur-tabs-set-icons t
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-set-bar 'left
        centaur-tabs-set-modified-marker t
        centaur-tabs-close-button "✕"
        centaur-tabs-modified-marker "•"
        centaur-tabs-icon-type 'nerd-icons
        centaur-tabs-cycle-scope 'tabs
        centaur-tabs-style "bar"
        centaur-tabs-height 24)
  :config
  ;; Disable tabs in transient/popup-like buffers
  (dolist (hook '(dashboard-mode-hook
                  calendar-mode-hook
                  helpful-mode-hook
                  help-mode-hook))
    (add-hook hook #'centaur-tabs-local-mode))

  (centaur-tabs-mode 1))


(use-package magit
  :ensure t)

(provide 'ui)

;;; ui.el ends here
