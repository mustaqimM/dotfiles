;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Mustaqim Malim"
      user-mail-address "mustaqim@pm.me")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka Medium" :size 16 :weight 'medium))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-tomorrow-night)
(setq doom-themes-treemacs-theme "doom-colors")
(setq treemacs-width 22)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/Library/Cloud/Org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


(add-to-list 'auto-mode-alist '("\\template\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\vifmrc\\'" . vimrc-mode))
;(add-to-list 'auto-mode-alist '("\\.vue$" . vue-mode))
(set-file-template! "\\.vue$" :trigger "__vue" :mode 'vue-mode)

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'vue-mode)
  )
  ;(add-to-list 'flycheck-checkers 'rustic-clippy))
  ;(add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

(defun my-fly-mode-hook ()
  (flycheck-inline-mode 't))
(with-eval-after-load 'flycheck
  (add-hook! 'flycheck-mode-hook  'my-fly-mode-hook))


(setq centaur-tabs-style "alternate"
      centaur-tabs-height 22
      ;centaur-tabs-set-icons t
      ;centaur-tabs-set-modified-marker t
      ;centaur-tabs-show-navigation-buttons nil
      ;centaur-tabs-set-bar 'under
      centaur-tabs-close-button ""
      x-underline-at-descent-line t)

(after! centaur-tabs
  (defun centaur-tabs-hide-tab (x)
    "Do no to show buffer X in tabs."
    (let ((name (format "%s" x)))
      (or
       ;; Current window is not dedicated window.
       (window-dedicated-p (selected-window))

       ;; Buffer name not match below blacklist.
       (string-prefix-p "*epc" name)
       (string-prefix-p "*helm" name)
       (string-prefix-p "*Compile-Log*" name)
       (string-prefix-p "*lsp" name)
       (string-prefix-p "*company" name)
       (string-prefix-p "*Flycheck" name)
       (string-prefix-p "*tramp" name)
       (string-prefix-p " *Mini" name)
       (string-prefix-p "*help" name)
       (string-prefix-p "*straight" name)
       (string-prefix-p " *temp" name)
       (string-prefix-p "*Help" name)
       (string-prefix-p "*which-key*" name)
       (string-prefix-p "*doom*" name)
       (string-prefix-p "*scratch*" name)
       (string-prefix-p "*Messages*" name)
       (string-prefix-p "*Warnings*" name)
       (string-prefix-p "*Treemacs-Scoped-Buffer-Perspective main*" name)

       ;; Is not magit buffer.
       (and (string-prefix-p "magit" name)
            (not (file-name-extension name)))
       )))
  )
;;(centaur-tabs-hide-tab-function 'centaur-tabs-hide-tab)

;;(add-to-list 'default-frame-alist '(fullscreen . maximized))

