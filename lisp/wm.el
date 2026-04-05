;;; wm.el --- Window manager configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; EWM compositor configuration

;;; Code:

(use-package ewm
  :ensure t
  :bind (:map ewm-mode-map
	   ;; Window Manager
       ("s-d" . consult-buffer)
       ("s-q" . kill-buffer-and-window)
       ("s-S-q" . tab-close)
	   ("s-j" . tab-new)
	   ("C-q" . q)
	   ("s-m" . ewm-left)
	   ("s-n" . ewm-down)
	   ("s-e" . ewm-up)
	   ("s-i" . ewm-right)
	   ("s-z" . split-window-right)
	   ("s-k" . split-window-below)
	   ("s-a" . ewm-toggle-fullscreen)
	   
       ("s-S-q" . (lambda () (interactive) (start-process "pkill" nil "pkill emacs")))

	   ;; Applications
       ("s-<return>" . (lambda () (interactive) (start-process "foot" nil "foot")))
       ("s-SPC" . xdg-launcher-run-app)
       ("s-v" . (lambda () (interactive) (start-process-shell-command "cliphist" nil "cliphist list | rofi -dmenu | cliphist decode | wl-copy")))
       ("s-b" . (lambda () (interactive) (start-process "zen-browser" nil "helium-browser")))
       ("s-f" . (lambda () (interactive) (start-process "thunar" nil "thunar")))
       ("s-u" . ewm-lock-session)
       ("s-p" . (lambda () (interactive) (start-process-shell-command "connect" nil "connect")))
       ("s-h" . (lambda () (interactive) (start-process "rmpc" nil "foot" "-e" "rmpc")))
       ("s-?" . (lambda () (interactive) (start-process "rofi" nil "rofi" "-show" "recursivebrowser")))
       ("s-," . (lambda () (interactive) (start-process-shell-command "solemn" nil "solemn")))
       ("S-s-SPC" . (lambda () (interactive) (start-process-shell-command "notes" nil "notes")))
       ("C-s-SPC" . (lambda () (interactive) (start-process "waypaper" nil "waypaper")))

       ;; Volume / Brightness
       ("<AudioRaiseVolume>" . (lambda () (interactive) (start-process-shell-command "osd" nil "osd volume 5%+")))
       ("<AudioLowerVolume>" . (lambda () (interactive) (start-process-shell-command "osd" nil "osd volume 5%-")))
       ("<AudioMute>" . (lambda () (interactive) (start-process-shell-command "osd" nil "osd volume toggle")))
       ("<MonBrightnessUp>" . (lambda () (interactive) (start-process-shell-command "osd" nil "osd brightness 10%+")))
       ("<MonBrightnessDown>" . (lambda () (interactive) (start-process-shell-command "osd" nil "osd brightness 10%-")))

       ;; Screenshots
       ("<print>" . (lambda () (interactive) (start-process-shell-command "screenshot" nil "screenshot clip")))
       ("s-<print>" . (lambda () (interactive) (start-process-shell-command "screenshot" nil "screenshot")))
       ("S-s-<print>" . (lambda () (interactive) (start-process-shell-command "screenshot" nil "screenshot ocr")))
       ("C-s-<print>" . (lambda () (interactive) (start-process-shell-command "screenshot" nil "screenshot window")))
       ("M-s-<print>" . (lambda () (interactive) (start-process-shell-command "screenshot" nil "screenshot full")))
       ("C-S-s-<print>" . (lambda () (interactive) (start-process-shell-command "screenshot" nil "screenshot color"))))

  :config
  (setq ewm-input-config
      '((touchpad :natural-scroll t :tap t :dwt t)
        (mouse :accel-profile "flat")
        (trackpoint :accel-speed 0.5)))
  
  (setq ewm-focus-follows-mouse t)
  (setq ewm-mouse-follows-focus f)

  (add-to-list 'ewm-intercept-prefixes ?\s-a)
    
  (add-hook 'ewm-output-config-changed-hook
    (lambda (_event)
      (start-process-shell-command "autostart" nil "~/.config/scripts/autostart.sh"))))

(provide 'wm)
;;; wm.el ends here
