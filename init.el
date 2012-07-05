(push "/usr/local/bin" exec-path)

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))


;; Mac keyboard modifier key
;;(setq mac-command-modifier 'meta)
;;(setq mac-option-modifier 'alt)
;;(setq mac-control-modifier 'alt)

(setq ns-command-modifier 'meta)
(setq ns-function-modifier 'super)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)
(setq visible-bell t)

(fset 'yes-or-no-p 'y-or-n-p)

(delete-selection-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(show-paren-mode t)
(column-number-mode t)
(set-fringe-style -1)
(tooltip-mode -1)
(setq frame-title-format "emacs@%b")
(windmove-default-keybindings)
(desktop-save-mode 1)
(ns-toggle-fullscreen)
(server-start)

;; Font

;; (set-frame-font "Menlo-15")
(set-fontset-font
    (frame-parameter nil 'font)
    'han
    (font-spec :family "Hiragino Sans GB" ))

;; Theme
(add-to-list 'custom-theme-load-path 
             "~/.emacs.d/themes/solarized")
(add-to-list 'custom-theme-load-path 
             "~/.emacs.d/themes/zenburn")

;; (load-theme 'solarized-light t)
(load-theme 'solarized-dark t) ;; solarized dark theme 
;;(load-theme 'tango' t)
;;(load-theme 'zenburn' t)


;; Utils

(defun end-of-line-newline ()
  "function like vim 'o' key"
  (interactive)
  (move-end-of-line 1)
  (newline)
)

(defun move-up-five-line ()
  (interactive)
  (previous-line 5)
)

(defun move-down-five-line ()
  (interactive)
  (next-line 5)
)


;; Key Binding

(global-set-key (kbd "M-t") 'textmate-goto-file)
(global-set-key [home] 'textmate-clear-cache)
(global-set-key (kbd "M-]") 'textmate-shift-left)
(global-set-key (kbd "C-]") 'textmate-shift-right)
(global-set-key (kbd "M-;") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "<f5>") 'ruby-compilation-this-buffer)
(global-set-key (kbd "M-1") 'set-mark-command)

;; Utils Binding
(global-set-key (kbd "M-RET") 'end-of-line-newline)
(global-set-key (kbd "M-p") 'move-up-five-line)
(global-set-key (kbd "M-n") 'move-down-five-line)

(global-set-key [kp-delete] 'rinari-find-model)
(global-set-key [end] 'rinari-find-view)
(global-set-key [next] 'rinari-find-controller)
;; (global-set-key [kp-4] 'rinari-find-stylesheet)
;; (global-set-key [kp-5] 'rinari-find-javascript)
(global-set-key [prior] 'rinari-find-rspec)


(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)

;; start of plugins
(add-to-list 'load-path "~/.emacs.d/plugins")
(load "~/.emacs.d/plugins/smart-copy")


(require 'ido)
(ido-mode t)

;; autopair
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'init-auto-complete)

;; Rinari
(add-to-list 'load-path "~/.emacs.d/plugins/rinari")
(require 'rinari)
(add-hook 'slim-mode-hook  #'(lambda () (rinari-minor-mode)))

;; Textmate mode
(add-to-list 'load-path "~/.emacs.d/plugins/textmate.el")
(require 'textmate)
(textmate-mode)

(add-to-list 'load-path "~/.emacs.d/plugins/rvm.el")
(require 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session

;; (add-to-list 'load-path "~/.emacs.d/plugins/haml-mode")
;; (require 'haml-mode)
;; (add-to-list 'load-path "~/.emacs.d/plugins/sass-mode")
;; (require 'sass-mode)

;;cucumber feature mode
;;(add-to-list 'load-path "~/.emacs.d/plugins/cucumber.el")
;;(require 'feature-mode)
;;(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

(add-to-list 'load-path "~/.emacs.d/plugins/mode-compile")
(add-to-list 'load-path "~/.emacs.d/plugins/rspec-mode")
(require 'rspec-mode)

(add-to-list 'load-path "~/.emacs.d/plugins/coffee-mode")
(require 'coffee-mode)

(add-to-list 'load-path "~/.emacs.d/plugins/js2-mode")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'js-comint)
;; Use node as our repl
(setq inferior-js-program-command "node")

(add-to-list 'load-path "~/.emacs.d/plugins/slim-mode")
(require 'slim-mode)

(add-to-list 'load-path "~/.emacs.d/plugins/scss-mode")
(require 'scss-mode)

(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)

(yas/load-directory "~/.emacs.d/plugins/yasnippets-rails/rails-snippets")
(yas/initialize)


;; Files Types

;;coffee
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;;slim
(add-to-list 'auto-mode-alist '("\\.slim$" . slim-mode))

;;scss
(add-to-list 'auto-mode-alist '("\\.scss\\$" . scss-mode))
(setq scss-compile-at-save nil)

;;rails
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))

;; Yaml
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; Variable set

;; FIXME

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start nil)
 '(ac-dwim nil)
 '(css-indent-offset 2)
 '(eol-mnemonic-mac "(Mac)")
 '(js2-basic-offset 2)
 '(js2-cleanup-whitespace t)
 '(make-backup-files nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-candidate-face ((t (:background "White" :foreground "black" :weight thin))))
 '(ac-selection-face ((t (:background "Magenta" :foreground "white" :weight extra-bold))))
 '(hl-line ((t (:inherit highlight :background "selectedMenuItemTextColor" :inverse-video nil :underline nil :slant normal :weight normal))))
 '(popup-face ((t (:background "selectedMenuItemTextColor" :foreground "controlDarkShadowColor"))))
 '(popup-menu-mouse-face ((t (:background "Purple" :foreground "white")))))
