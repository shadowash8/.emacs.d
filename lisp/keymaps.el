;;; keymaps.el --- Meow setup  -*- lexical-binding: t; -*-
;;; Commentary:
;; This is a helix or kakone stle keybinds setup

;;; Code:
(defun studium/fuzzy-find-files-in-directory ()
  "Fuzzy find files in the current directory."
  (interactive)
  (find-file
   (completing-read "Find file: "
                    (directory-files-recursively "." ".*"))))

(defun studium/grep-current-directory ()
  "Run ripgrep in the current directory."
  (interactive)
  (let ((default-directory (if (derived-mode-p 'dired-mode)
                               (dired-dwim-target-directory)
                             default-directory)))
    (consult-ripgrep default-directory)))

(defun studium/open-personal-config ()
  "Fuzzy search and open a file in `~/.emacs.d`."
  (interactive)
  (let* ((config-dir "~/.emacs.d")
         (all-files (directory-files-recursively
                     config-dir "\\.el$"
                     nil
                     (lambda (file)
                       (not (or (string-match-p "/elpa/" file)
                                (string-match-p "/straight/" file)
                                (string-match-p "/server/" file))))))
         (selected-file (completing-read "Find config file: " all-files)))
    (find-file selected-file)))

(defun studium/org-find-file ()
  "Fuzzy search and open a file in `~/org`."
  (interactive)
  (find-file
   (completing-read "Find org file: "
                    (directory-files-recursively "~/org" "\\.org$"))))

(defun studium/kill-char ()
  "Kills a character adding it to killring, like x in vim"
  (interactive)
  (kill-region (point) (1+ (point))))

(defun studium/paste-below ()
  "Vim p: paste after cursor (characterwise) or below current line (linewise)."
  (interactive)
  (when (null kill-ring)
    (user-error "Kill ring is empty"))
  (let ((text (current-kill 0)))
    (cond
     ;; Active region: replace selection, old selection → kill-ring
     ((use-region-p)
      (let ((beg (region-beginning)))
        (kill-region (region-beginning) (region-end))
        (insert text)
        (goto-char beg)))
     ;; Linewise: paste below current line, cursor to first non-blank
     ((string-suffix-p "\n" text)
      (let* ((content (substring text 0 (1- (length text))))
             (target nil))
        (end-of-line)
        (insert "\n")
        (setq target (point))
        (insert content)
        (goto-char target)
        (back-to-indentation)))
     ;; Characterwise: paste after cursor, cursor on last pasted char
     (t
      (unless (or (eobp) (eolp))
        (forward-char 1))
      (insert text)
      (backward-char 1)))))

(defun studium/paste-above ()
  "Vim P: paste before cursor (characterwise) or above current line (linewise)."
  (interactive)
  (when (null kill-ring)
    (user-error "Kill ring is empty"))
  (let ((text (current-kill 0)))
    (cond
     ;; Active region: replace selection, old selection → kill-ring
     ((use-region-p)
      (let ((beg (region-beginning)))
        (kill-region (region-beginning) (region-end))
        (insert text)
        (goto-char beg)))
     ;; Linewise: paste above current line, cursor to first non-blank
     ((string-suffix-p "\n" text)
      (let* ((content (substring text 0 (1- (length text))))
             (target nil))
        (beginning-of-line)
        (setq target (point))
        (insert content "\n")
        (goto-char target)
        (back-to-indentation)))
     ;; Characterwise: paste before cursor, cursor on last pasted char
     (t
      (insert text)
      (backward-char 1)))))

;; --- Meow Setup ---

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-colemak-dh)

  (meow-leader-define-key
   '("?" . meow-cheatsheet)
   
   ;; --- Doom-style File/Buffer Bindings ---
   '("SPC" . studium/fuzzy-find-files-in-directory)
   '("." . embark-act)
   '("w" . save-buffer)
   '("u" . undo-tree-visualize)
   '("/" . consult-line)
   '("e" . neotree-toggle)

   ;; Files (f)
   '("f f" . find-file)
   '("f r" . recentf-open-files)
   '("f d" . dired)
   '("f g" . studium/grep-current-directory)
   '("f p" . studium/open-personal-config)

   ;; Buffers (b)
   '("b b" . consult-buffer)
   '("b q" . kill-current-buffer)
   '("b s" . save-buffer)
   '("b k" . (lambda () (interactive) (kill-buffer (current-buffer))))
   '("b c" . outline-hide-sublevels)
   '("b e" . outline-show-all)

   ;; Projects (p)
   '("p p" . project-switch-project)
   '("p f" . project-find-file)
   '("p b" . consult-project-buffer)
   '("p k" . project-kill-buffers)

   ;; Search (s)
   '("s f" . consult-find)
   '("s g" . consult-ripgrep)
   '("s o" . universal-launcher--web-search)

   ;; Org & Roam (o / n)
   '("o a" . org-agenda)
   '("o c" . org-capture)
   '("o l" . org-store-link)
   '("o f" . studium/org-find-file)
   '("n r f" . org-roam-node-find)
   '("n r i" . org-roam-node-insert)
   '("n r c" . org-roam-capture)
   '("n j" . org-roam-dailies-capture-today)

   ;; LSP (l)
   '("l f" . lsp-format-buffer)
   '("l r" . lsp-rename)
   '("l a" . lsp-execute-code-action)

   ;; Help (h)
   '("h f" . describe-function)
   '("h v" . describe-variable)
   '("h k" . describe-key)
   '("h m" . describe-mode)

   ;; Git (g)
   '("g" . magit-status)

   ;; Workspaces/Tabs (<TAB>)
   '("<TAB> n" . +workspace/new)
   '("<TAB> d" . +workspace/delete)
   '("<TAB> ." . +workspace/switch-to)
   '("<TAB> [" . tab-bar-switch-to-prev-tab)
   '("<TAB> ]" . tab-bar-switch-to-next-tab)

   ;; --- Org Local Leader (mapped to SPC m) ---
   '("m t t" . org-todo)
   '("m t s" . org-schedule)
   '("m t d" . org-deadline)
   '("m l i" . org-insert-link)
   '("m l o" . org-open-at-point)
   '("m c i" . org-clock-in)
   '("m c o" . org-clock-out)
   '("m x c" . org-toggle-checkbox))

  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("1" . meow-expand-1)
   '("2" . meow-expand-2)
   '("3" . meow-expand-3)
   '("4" . meow-expand-4)
   '("5" . meow-expand-5)
   '("6" . meow-expand-6)
   '("7" . meow-expand-7)
   '("8" . meow-expand-8)
   '("9" . meow-expand-9)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . (lambda () (interactive) (end-of-line) (meow-insert)))
   '("b" . meow-back-word)
   '("c" . meow-change)
   '("d" . meow-clipboard-kill)
   '("f" . flash-jump)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("i" . meow-insert)
   '("j" . meow-join)
   '("m" . meow-mark-word)
   '("o" . meow-open-below)
   '("O" . meow-open-above)
   '("p" . studium/paste-below)
   '("P" . studium/paste-above)
   '("r" . meow-replace)
   '("s" . meow-change-char)
   '("u" . undo-tree-undo)
   '("v" . meow-search)
   '("w" . meow-next-word)
   '("x" . meow-line)
   '("X" . studium/kill-char)
   '("y" . meow-clipboard-save)
   
   ;; LSP / Navigation (replacing Evil 'gd', 'K', etc.)
   '("g d" . lsp-find-definition)
   '("g r" . lsp-find-references)
   '("K" . lsp-ui-doc-glance)
   '("]" . flymake-goto-next-error)
   '("[" . flymake-goto-prev-error)

   ;; Folds
   '("z o" . kirigami-open-fold)
   '("z c" . kirigami-close-fold)))

;; Meow
(use-package meow
  :demand t
  :config
  (meow-setup)
  (meow-global-mode 1)
  ;; Keep your custom things
  (meow-thing-register 'angle '(regexp "<" ">") '(regexp "<" ">"))
  (setq meow-char-thing-table 
        '((?\( . round) (?\[ . square) (?\{ . curly) (?w . window) (?b . buffer) (?l . line))))

(global-set-key (kbd "C-s") #'save-buffer)
(global-set-key (kbd "C-v") #'clipboard-yank)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(provide 'keymaps)
;;; keymaps.el ends here
