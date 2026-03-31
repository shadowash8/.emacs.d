;;; functions.el --- Extra functions -*- lexical-binding: t; -*-
;;; Commentary:
;; Here are some extra functions needed

;;; Code:

(defun +org/refile-to-current-file ()
  "Refile the current subtree to the current file."
  (interactive)
  (let ((org-refile-targets `((,(buffer-file-name) :maxlevel . 3))))
    (org-refile)))

(defun +org/refile-to-running-clock ()
  "Refile the current subtree to the heading currently clocked in."
  (interactive)
  (let ((org-refile-targets '((nil :tag "CLOCKING" :maxlevel . 1))))
    (org-refile)))

(defun +org/refile-to-last-location ()
  "Refile the current subtree to the last refiling location."
  (interactive)
  (org-refile nil nil '(4))) ; 4 = use last refiling location

(defun +org/refile-to-file ()
  "Refile the current subtree to a heading in a selected Org file."
  (interactive)
  ;; Step 1: select a file from org-directory
  (let* ((org-files (directory-files org-directory t "\\.org$"))
         (file (completing-read "Refile to file: " org-files nil t)))
    ;; Step 2: select a heading in the chosen file
    (let ((org-refile-targets `((,file :maxlevel . 5)))  ;; all headings up to level 5
          (org-refile-use-outline-path 'full)          ;; show full path
          (org-outline-path-complete-in-steps nil)     ;; select in one step
          (org-refile-allow-creating-parent-nodes nil)) ;; don't auto-create
      (org-refile))))



(defun +org/refile-to-other-window ()
  "Refile the current subtree to a heading in another window."
  (interactive)
  (let ((org-refile-use-outline-path 'file)
        (org-refile-allow-creating-parent-nodes 'confirm))
    (org-refile nil nil nil t))) ; t = other window

(defun +org/refile-to-other-buffer ()
  "Refile the current subtree to another buffer."
  (interactive)
  (let ((org-refile-use-outline-path 'file))
    (call-interactively 'org-refile)))

(defun +org/refile-to-visible ()
  "Refile the current subtree to a visible heading in current buffer."
  (interactive)
  (let ((org-refile-targets '((nil :maxlevel . 3))))
    (org-refile)))


(defun org-lap--find-drawer (name)
  (save-excursion
    (org-back-to-heading t)
    (let ((end (save-excursion (outline-next-heading) (point)))
          found)
      (while (re-search-forward (format ":%s:" name) end t)
        (when (org-at-drawer-p)
          (setq found (match-beginning 0))
          (setq end (point-max)))) ;; halt search
      found)))

;; ORG-LAP-TIMER
;; This function creates a record of laps inside a org-task
(defun org-lap-timer ()
  (interactive)
  (unless (eq major-mode 'org-mode)
    (user-error "Not in an org buffer"))

  (let* ((title (nth 4 (org-heading-components)))
         (start (current-time))
         (last (current-time))
         (laps '()))

    (message "SPACE = lap | C-g = finish for: %s" title)

    (catch 'done
      (while t
        (let ((key (read-key)))
          (cond
           ((eq key ?\s)
            (let* ((now (current-time))
                   (diff (float-time (time-subtract now last))))
              (setq last now)
              (push diff laps)
              (message "%s | Lap: %.3f sec" title diff)))
           ((eq key ?\C-g)
            (throw 'done t))))))

    (save-excursion
      (org-back-to-heading t)

      ;; Find LAPBOOK drawer manually
      (let ((drawer-pos (org-lap--find-drawer "LAPBOOK")))
        (if drawer-pos
            ;; Go to the :END: of existing drawer
            (progn
              (goto-char drawer-pos)
              (re-search-forward ":END:")
              (forward-line 0))
          ;; Create new drawer
          (progn
            (org-end-of-meta-data)
            (insert ":LAPBOOK:\n:END:\n")
            (forward-line -1))))

      ;; Insert session data
      (insert
       (format "  - Lap Timer [%s]\n"
               (format-time-string "%Y-%m-%d %H:%M")))
      (insert
       (format "    - Total: %.3f sec\n"
               (float-time (time-subtract last start))))
      (dolist (l (reverse laps))
        (insert (format "    - Lap: %.3f sec\n" l))))

    (message "Saved in LAPBOOK for: %s" title)))


(defun my/org-clock-full-path ()
  (when (org-clocking-p)
    (with-current-buffer (marker-buffer org-clock-marker)
      (save-excursion
        (goto-char org-clock-marker)
        (let ((path (org-get-outline-path t t)))
          (mapconcat #'identity
                     (if (> (length path) 1)
                         (last path 2)
                       path)
                     " -> "))))))

(defun my/disable-line-numbers ()
  (display-line-numbers-mode -1))


(provide 'functions)
;;; functions.el ends here
