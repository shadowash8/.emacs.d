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
(require 'completion)

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
   '("a31f4b07d52809a5f0599d9fa6ac9dfe4014ece84ab0e24e82f80292ff990fbc"
     "c73cbe176bbe7a680b25cc12f322cd0e8991f65cd7e42d8d974021949672a1da"
     "9543eabaaeba752f26ebdf4ae7a69de09725aca235305c7a7bfe1626b6080604"
     "ea7dc3cc315d2b954ffc6fccf75ccf1893dd61a1b4d759981b88fe9bf48271b9"
     "61393bc2c79db1ad674c1ec5638f4e859ad9396bd340f8f356ec13b7fd7eec4a"
     "f283d33e371382577b0528ffa13f7518bd445f793ca2f5dc6f15e218ff28b7d5"
     "a42186a9668011a45cfedc35cd2c99d5f7657e06796a186ad6edd46e1c4a17f8"
     "1f9c1db277a41c442b52d0b72b7fb328ffda01ba1792158eade55416f4b87d83"
     "2b8cefdb7c4972ad0bd5c66dad95ee8e7e3838ec07acb7b831cbc4296f210b3f"
     "3f203cad002f923d4f8e6b2c14f24ba13c50b7e41801c5ae9d4223e23dc33830"
     "6909d9d7a6f51b7b9c53f84e49e4139d56df43e63bfe7436740c808ba809b497"
     "d96664492c51dd800d47f52e66e986cc744f2b5a0c2a59fade85209a2f314075"
     "6e918674f662e831d071bd00da992fa72c77defd033ed9373e950bc97995c91c"
     "729f5cbecb5f8cd6ac2bdee16d3f257cfb3a0699f85ebd5b75273b5672aad259"
     "6b4c5ac6095362a79c9237fd1fd23fd01fe56b13108dd4b3f353a962c8224f86"
     "86dc850ee4f37167042c33afa42390e44963397ef8b587c8530bb574d031fd03"
     "d3b0cd39eafc2eeddb8e5825f4bac9a5e30ce324fe46c6b4d9f150da8f7626be"
     "0e18d7845ebe8a369e7a07bf5461efec18f1b2ad729732fb927359aa2705bc0f"
     "7422b50d6bda967c329cba8215272e8aa6a786e018b7ef5e8d60b0f9d57d62d2"
     "f1c8202c772d1de83eda4765fe21429a528a4fb350a28394d3705fe9678ed1f9"
     "cee8b387a39aeb2a749b02950ea46d6844b8d3786ac5da8623fdbe569c934aae"
     "723cb1022e81737895b010f315c08dccdfb4cb9b4d86256a4fb222c4a923a698"
     "b8f9f3d4d3c78b1959be9e40769475890c5cda484e052395a5001f50dbe28016" default))
 '(package-vc-selected-packages
   '((janet-ts-mode :url "https://github.com/sogaiu/janet-ts-mode"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
