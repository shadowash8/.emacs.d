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

;; Load theme based on window manager
(defun get-current-wm ()
  "Detect the current window manager."
  (let ((desktop-env (getenv "XDG_CURRENT_DESKTOP"))
        (session-type (getenv "DESKTOP_SESSION")))
    (cond
     ((or (string-match-p "hyprland" (or desktop-env ""))
          (string-match-p "hyprland" (or session-type "")))
      'hyprland)
     ((or (string-match-p "dwm" (or desktop-env ""))
          (string-match-p "dwm" (or session-type ""))
          (and (executable-find "dwm") 
               (string-match-p "dwm" (shell-command-to-string "ps -e | grep dwm"))))
      'dwm)
     (t 'unknown))))

(load-file "~/.config/colors/minimal-matugen-theme.el")

;; Load appropriate theme based on WM
(pcase (get-current-wm)
  ('hyprland (load-theme 'minimal-matugen t))
  ('dwm (load-theme 'minimal-black t))
  (_ (load-theme 'minimal-matugen t))) ;; Default to matugen if unknown

(provide 'themes)
;;; themes.el ends here
