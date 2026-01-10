;;; org-config.el --- Org and Org-roam configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Configuration for Org-mode and Org-roam in vanilla Emacs.

;;; Code:

;; ORG-MODE
(straight-use-package 'org)

(use-package org
  :defer t)

(with-eval-after-load 'org
  (setq org-directory "~/Documents/org/")

  (setq org-agenda-files (list
                        "~/Documents/org/inbox.org"
                        "~/Documents/org/personal.org"
                        "~/Documents/org/school.org"
                        "~/Documents/org/studies.org"))
  
  ;; TODO keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WORKING(w!)" "WAIT(W@)" "|" "DONE(d!)" "CANC(c@)")))

  ;; Capture templates
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "~/Documents/org/inbox.org" "Inbox")
           "* TODO %^{Task}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("a" "Appointment" entry
           (file+headline "~/Documents/org/personal.org" "Appointments")
           "* %^{Event}\n%^{SCHEDULED}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("p" "Project" entry
           (file+headline "~/Documents/org/projects.org" "Projects")
           "* PROJ %^{Project name}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n** TODO %?")
		  ("c" "Chore" entry
           (file+headline "~/Documents/org/personal.org" "Chore")
           "* %^{Event}\n%^{SCHEDULED}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("i" "Idea" entry
           (file+headline "~/Documents/org/ideas.org" "Ideas")
           "** IDEA %^{Idea}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")
          ("n" "Note" entry
           (file+headline "~/Documents/org/notes.org" "Inbox")
           "* [%<%Y-%m-%d %a>] %^{Title}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?"
           :prepend t)))

  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate))


;; ORG-ROAM
(use-package org-roam
  :ensure t
  :defer t
  :custom
  (org-roam-directory (file-truename "~/Documents/org/notes/"))
  :config
  ;; Display template
  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

  ;; Auto-sync database
  (org-roam-db-autosync-mode)

  ;; Optional: org-roam-protocol
  (require 'org-roam-protocol)

  ;; Dailies Configuration
  (setq org-roam-dailies-capture-templates
      '(("d" "default" plain
         (file "templates/dailies.org")
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n")
         :unnarrowed t))))

;; ORG-POMODORO
(use-package org-pomodoro
  :ensure t
  :config
  (setq org-pomodoro-length 50)
  (setq org-pomodoro-short-break-length 10)
  (setq org-pomodoro-long-break-length 30))

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

(provide 'org-config)
;;; org-config.el ends here

