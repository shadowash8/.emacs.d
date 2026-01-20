;;; themes.el --- Theme configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Theme setup for Emacs
;;; Code:
;; Doom Themes
(use-package doom-themes
  :ensure t
  :config
;  (load-theme 'doom-tokyo-night t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Minimal Themes
(use-package minimal-theme
  :straight (minimal-theme :type git :host github :repo "shadowash8/emacs-minimal-theme"))

;; Xresources Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'xresources t)

(defun my/reload-xresources-theme ()
  "Force Emacs to forget the theme and reload it from disk."
  (interactive)
  ;; 1. Point Emacs to your theme folder
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
  ;; 2. Disable the theme if it's currently active
  (disable-theme 'xresources)
  ;; 3. Remove it from the known themes list so it's fully 'unloaded'
  (setq custom-enabled-themes (remq 'xresources custom-enabled-themes))
  ;; 4. Load it fresh
  (load-theme 'xresources t)
  (message "Theme updated!"))

(provide 'themes)
;;; themes.el ends here
