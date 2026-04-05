;;; init.el --- Personal Emacs configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Entry point for my Emacs setup.
;; Loads custom Lisp modules, applies performance tweaks, and sets up packages.

;;; Code:

;; Load Path Setup
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp/packages" user-emacs-directory))

;; Performance Tweaks
;; Increase garbage collection threshold to reduce GC pauses during heavy ops.
(setq gc-cons-threshold #x40000000)

;; Increase process output read size (default is 4KB, bump to 4MB).
(setq read-process-output-max (* 4 1024 1024))

;; reset GC threshold after startup for balance
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold #x1000000)))

;; Modules
(require 'packages)     ;; package.el / straight.el / use-package setup
(require 'functions)    ;; helper functions
(require 'config)       ;; general settings
(require 'keymaps)      ;; global + leader keymaps

(require 'themes)       ;; theme setup
(require 'editing)      ;; editing enhancements
(require 'org)          ;; org 
(require 'ui)           ;; UI elements (modeline, dashboard, etc.)
(require 'lsp)          ;; LSP and coding
(require 'wm)           ;; emacs as a operating system

(provide 'init)
;;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("882f29967c553f6557afc466308e253a6235f82df4028b02c0bdcc8a2cf9b407"
	 "70829f6a709c2b14ae3927897b67ed638af08235464b7cb64b32db78505ae9a3"
	 default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
