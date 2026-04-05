;;; wm.el --- Window manager configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; EWM compositor configuration

;;; Code:

(use-package ewm
  :ensure t
  :bind (:map ewm-mode-map
         ("s-d" . consult-buffer)
         ("s-<return>" . (lambda ()
                    (interactive)
                    (start-process "foot" nil "foot")))
         ;; This ensures Super+Space always launches Rofi
         ("s-SPC" . shell-command)
         ;; This ensures Super+f always launches Thunar
         ("s-f" . (lambda ()
                    (interactive)
                    (start-process "thunar" nil "thunar"))))
  :config
  (setq ewm-focus-follows-mouse t)
  
  (setq ewm-input-config
      '((touchpad :natural-scroll f :tap t :dwt t)
        (mouse :accel-profile "flat")
        (trackpoint :accel-speed 0.5))))

(provide 'wm)
;;; wm.el ends here
