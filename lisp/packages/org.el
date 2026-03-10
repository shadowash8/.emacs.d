;;; org.el --- Org configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Configuration and appearance for Org-mode and Org-roam in vanilla Emacs.

;;; Code:

;; ORG-MODE
(straight-use-package 'org)

(defvar org-read-date-minibuffer-local-map (make-sparse-keymap))
(defvar org-mode-map (make-sparse-keymap))

(use-package org
  :ensure t
  :straight t
  :init
  (setq org-directory "~/org"))

(with-eval-after-load 'org
  (setq org-directory "~/org/")

  (setq org-agenda-files (list
                        "~/org/inbox.org"
                        "~/org/personal.org"
                        "~/org/school.org"
                        "~/org/studies.org"))
  
  ;; TODO keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WORKING(w!)" "WAIT(W@)" "|" "DONE(d!)" "CANC(c@)")))

  ;; Capture templates
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "~/org/inbox.org" "Inbox")
           "* TODO %^{Task}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("a" "Appointment" entry
           (file+headline "~/org/personal.org" "Appointments")
           "* %^{Event}\n%^{SCHEDULED}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("p" "Project" entry
           (file+headline "~/org/projects.org" "Projects")
           "* PROJ %^{Project name}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n** TODO %?")
		  ("c" "Chore" entry
           (file+headline "~/org/personal.org" "Chore")
           "* %^{Event}\n%^{SCHEDULED}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("i" "Idea" entry
           (file+headline "~/org/ideas.org" "Ideas")
           "** IDEA %^{Idea}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("n" "Note" entry
           (file+headline "~/org/notes.org" "Inbox")
           "* [%<%Y-%m-%d %a>] %^{Title}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?"
           :prepend t)))

  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate))


;; ORG-ROAM
(use-package org-roam
  :ensure t
  :defer t
  :custom
  (org-roam-directory (file-truename "~/org/notes/"))
  :config
  ;; Display template
  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

  ;; Auto-sync database
  (org-roam-db-autosync-mode)

  ;; Optional: org-roam-protocol
  (require 'org-roam-protocol)
  
  ;; Dailies Configuration
  (setq org-roam-dailies-directory "~/org/daily/")
  (setq org-roam-dailies-capture-templates
      '(("d" "default" plain
         (file "templates/dailies.org")
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n")
         :unnarrowed t))))

;; HELPER FUNCTIONS
(defun my/org-clock-get-time-string ()
  "Return the currently clocked time as a string (e.g. \"1:23\").
Returns an empty string if no clock is running."
  (let ((m (org-clock-get-clocked-time)))
    (if (and m (> m 0))
        (org-minutes-to-clocksum-string m)
      "")))

(defun my/remove-properties (s)
  (substring-no-properties s))

(defun my/org-clock-task-and-time ()
  (if (org-clocking-p)
      (let* ((task (or (my/org-clock-full-path) ""))
             (short (if (> (length task) 40)
                        (concat (substring task 0 40) "...")
                      task)))
        (substring-no-properties
         (format "%s — %s"
                 short
                 (my/org-clock-get-time-string))))
    ""))

;;; ORG APPEARANCE

;; Hide leading stars, pretty bullets
(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :custom
  (org-modern-star nil)
  (org-modern-hide-stars t)
  (org-modern-block-name '("src" "quote"))
  (org-modern-table nil)
  (org-modern-ellipsis " ? "))

;; Pretty bullets
(use-package org-bullets-mode
  :ensure org-bullets
  :config
  :hook org-mode)

;; Indentation and bullets (pretty indentation lines)
(use-package org-modern-indent
  :straight (org-modern-indent :type git :host github :repo "jdtsmith/org-modern-indent")
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda))

;; Enable number line even with org-indent
(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode 1)
            (display-line-numbers-mode 1)))

;; Org Appear
(use-package org-appear
  :ensure t
  :commands (org-appear-mode)
  :hook (org-mode . org-appear-mode)
  :init
  (setq org-hide-emphasis-markers t
        org-appear-autoemphasis t
        org-appear-autolinks t
        org-appear-autosubmarkers t))


(provide 'org)
;;; org.el ends here
