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

(if (file-exists-p "~/.config/colors/minimal-matugen-theme.el")
    (progn
      (load-file "~/.config/colors/minimal-matugen-theme.el")
      (load-theme 'minimal-matugen t))
  (load-theme 'minimal-black t))

(provide 'themes)
;;; themes.el ends here
