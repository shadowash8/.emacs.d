;;; wm.el --- Window manager configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; EWM compositor configuration

;;; Code:

(use-package ewm
  :ensure t
  :bind (:map ewm-mode-map
       ("s-d" . consult-buffer)
       ("s-q" . kill-current-buffer)
       ("s-S-q" . (lambda () (interactive) (start-process "pkill" nil "pkill emacs")))
       ("s-<return>" . (lambda () (interactive) (start-process "foot" nil "foot")))
       ("s-SPC" . shell-command)
       ("s-v" . (lambda () (interactive) (start-process-shell-command "cliphist" nil "cliphist list | rofi -dmenu | cliphist decode | wl-copy")))
       ("s-b" . (lambda () (interactive) (start-process "zen-browser" nil "zen-browser")))
       ("s-f" . (lambda () (interactive) (start-process "thunar" nil "thunar")))
       ("s-u" . (lambda () (interactive) (start-process "gtklock" nil "gtklock")))
       ("s-p" . (lambda () (interactive) (start-process-shell-command "connect" nil "connect")))
       ("s-h" . (lambda () (interactive) (start-process "rmpc" nil "foot" "-e" "rmpc")))
       ("s-?" . (lambda () (interactive) (start-process "rofi" nil "rofi" "-show" "recursivebrowser")))
       ("s-," . (lambda () (interactive) (start-process-shell-command "solemn" nil "solemn")))
       ("C-s-," . (lambda () (interactive) (start-process-shell-command "silly" nil "silly")))
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
  
  (add-hook 'ewm-output-config-changed-hook
    (lambda (_event)
      (start-process-shell-command "autostart" nil "~/.config/scripts/autostart.sh"))))

(provide 'wm)
;;; wm.el ends here
