;;; xresources-theme.el --- Minimal Xresources theme via JSON -*- lexical-binding: t; -*-

(require 'json)

(defun xres-get-json (name)
  "Fetch a color from the Matugen/Wal JSON cache."
  (let* ((json-object-type 'hash-table)
         (json-key-type 'string)
         ;; Path to the generated color file
         (colors-json (json-read-file "~/.cache/wal/colors.json"))
         (colors-dict (gethash "colors" colors-json))
         (special-dict (gethash "special" colors-json)))
    (cond 
     ((string= name "background") (gethash "background" special-dict))
     ((string= name "foreground") (gethash "foreground" special-dict))
     ((string= name "cursor")     (gethash "cursor"     special-dict))
     (t (gethash name colors-dict)))))

(deftheme xresources "Minimal dark theme pulling from JSON.")

(let* ((class '((class color) (min-colors 89)))
       ;; --- Variables Mapped from JSON ---
       (background (xres-get-json "background"))
       (foreground (xres-get-json "foreground"))
       (cursor     (xres-get-json "cursor"))
       (border     (xres-get-json "color8")) 
       (failure    (xres-get-json "color1"))

       (region     (xres-get-json "color8"))
       (comment    (xres-get-json "color8"))
       (comment-delimiter comment)
       (string     (xres-get-json "color2"))
       (org-background background)

       (modeline-background          background)
       (modeline-foreground          foreground)
       (modeline-background-active   (xres-get-json "color8"))
       (modeline-foreground-active   foreground)
       (modeline-background-inactive background)
       (modeline-foreground-inactive comment)
       
       (tabbar-background            modeline-background)
       (tabbar-foreground            modeline-foreground)
       (tabbar-background-active     modeline-background-active)
       (tabbar-foreground-active     modeline-foreground-active)
       (tabbar-background-inactive   modeline-background-inactive)
       (tabbar-foreground-inactive   modeline-foreground-inactive)

       (hl-background region)
       (minibuffer cursor)

       ;; ANSI slots
       (color-red     (xres-get-json "color1"))
       (color-green   (xres-get-json "color2"))
       (color-yellow  (xres-get-json "color3"))
       (color-blue    (xres-get-json "color4"))
       (color-magenta (xres-get-json "color5"))
       (color-cyan    (xres-get-json "color6"))
       (color-white   (xres-get-json "color7")))

  (custom-theme-set-faces
   'xresources

   ;; --- Basic Stuff ---
   `(default ((,class (:background ,background :foreground ,foreground))))
   `(cursor ((,class (:background ,cursor :inverse-video t))))
   `(vertical-border ((,class (:foreground ,border))))
   `(fringe ((,class (:background ,background :foreground ,comment))))

   ;; --- Minibuffer ---
   `(minibuffer-prompt ((,class (:foreground ,minibuffer :weight bold))))

   ;; --- Region ---
   `(region ((,class (:background ,region))))
   `(secondary-selection ((,class (:background ,region))))

   ;; --- Syntax Faces ---
   `(font-lock-builtin-face ((,class (:foreground ,color-red :weight bold))))
   `(font-lock-constant-face ((,class (:foreground ,color-blue :weight bold))))
   `(font-lock-keyword-face ((,class (:foreground ,color-cyan :weight bold))))
   `(font-lock-type-face ((,class (:foreground ,foreground :slant italic))))
   `(font-lock-function-name-face ((,class (:foreground ,color-red :weight bold))))
   `(font-lock-variable-name-face ((,class (:foreground ,foreground))))
   `(font-lock-comment-delimiter-face ((,class (:foreground ,comment-delimiter))))
   `(font-lock-comment-face ((,class (:foreground ,comment))))
   `(font-lock-doc-face ((,class (:inherit (font-lock-comment-face)))))
   `(font-lock-string-face ((,class (:foreground ,string))))

   ;; --- Isearch ---
   `(isearch ((,class (:foreground ,foreground :background ,region :weight normal))))
   `(isearch-fail ((,class (:foreground ,failure :bold t))))
   `(lazy-highlight ((,class (:foreground ,foreground :background ,region))))

   ;; --- IDO ---
   `(ido-subdir ((,class (:foreground ,foreground :weight bold))))
   `(ido-only-match ((,class (:foreground ,foreground :weight bold))))

   ;; --- Paren Match ---
   `(show-paren-match ((,class (:background ,region))))
   `(show-paren-mismatch ((,class (:foreground ,failure :weight bold))))

   ;; --- Modeline ---
   `(mode-line
     ((,class (:inverse-video nil :overline nil :underline nil
               :foreground ,modeline-foreground-active
               :background ,modeline-background-active :box nil))))
   `(mode-line-buffer-id ((,class (:weight bold))))
   `(mode-line-inactive
     ((,class (:inverse-video nil :overline nil :underline nil
               :foreground ,modeline-foreground
               :background ,modeline-background :box nil))))

   ;; --- Tabs ---
   `(tab-bar ((t (:background ,tabbar-background :foreground ,tabbar-foreground :box nil))))
   `(tab-line ((t (:background ,tabbar-background :foreground ,tabbar-foreground :box nil))))
   `(tab-bar-tab ((t (:background ,tabbar-background-active :foreground ,tabbar-foreground-active :box nil))))

   ;; --- HL-Line ---
   `(hl-line ((,class (:background ,hl-background))))

   ;; --- Org Mode ---
   `(org-level-1 ((,class (:foreground ,color-red :weight bold))))
   `(org-level-2 ((,class (:foreground ,color-magenta :weight bold))))
   `(org-level-3 ((,class (:foreground ,color-yellow :weight bold))))
   `(org-level-4 ((,class (:foreground ,color-blue :weight bold))))
   `(org-level-5 ((,class (:foreground ,color-green :weight bold))))
   `(org-level-6 ((,class (:foreground ,color-cyan :weight bold))))
   `(org-level-7 ((,class (:foreground ,color-red :weight bold))))
   `(org-level-8 ((,class (:foreground ,color-white :weight bold))))
   `(org-document-title ((,class (:foreground ,foreground))))
   `(org-link ((,class (:background ,org-background :foreground ,foreground :underline t))))
   `(org-tag ((,class (:background ,org-background :foreground ,foreground))))
   `(org-warning ((,class (:background ,region :foreground ,foreground :weight bold))))
   `(org-todo ((,class (:background ,region :foreground ,foreground :weight bold))))
   `(org-done ((,class (:background ,region :foreground ,foreground :weight bold))))
   `(org-table ((,class (:background ,org-background))))
   `(org-block ((,class (:background ,org-background))))
   `(org-block-background ((,class (:background ,org-background :foreground ,foreground))))
   `(org-block-begin-line ((,class (:background ,org-background :foreground ,comment-delimiter :weight bold))))
   `(org-block-end-line ((,class (:background ,org-background :foreground ,comment-delimiter :weight bold))))

   ;; --- Centaur Tabs ---
   `(centaur-tabs-default ((t (:background ,tabbar-background :foreground ,tabbar-foreground :box nil))))
   `(centaur-tabs-selected ((t (:background ,tabbar-background-active :foreground ,tabbar-foreground-active :box nil))))
   `(centaur-tabs-unselected ((t (:background ,tabbar-background :foreground ,tabbar-foreground-inactive :box nil))))
   `(centaur-tabs-selected-modified ((t (:background ,tabbar-background :foreground ,color-red :box nil))))
   `(centaur-tabs-active-bar-face ((t (:background ,color-yellow :box nil))))
   ) 
)

(provide-theme 'xresources)
