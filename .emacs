;; .emacs

;; Set up package installation
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; Add our lisp directory to the load path
(add-to-list 'load-path "~/.emacs.d/lisp")

;;; Disable loading of "default.el" at startup
(setq inhibit-default-init t)

;; Turn off the blinking cursor
(blink-cursor-mode 0)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
(setq require-final-newline 'query)

;; Do not display a splash screen on startup
(setq inhibit-splash-screen t)

;; Show column-number in the mode line
(column-number-mode t)

;; Show column-number in the mode line
(line-number-mode t)

;; Use spaces instead of tabs for indent.
(setq-default indent-tabs-mode nil)

;; Set tab width for all buffers
(setq-default tab-width 4)

;; Don't show the menu, tool, or scroll bars
;;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Turn on semantic-mode and semantic-decoration-mode
(semantic-mode 1)
(global-semantic-decoration-mode 1)

;; Have ediff split windows horizontally
(setq ediff-split-window-function 'split-window-horizontally)

;; Use cscope
(require 'xcscope)

;; Use psvn
;;(require 'psvn)

;; Try to preserve the window configuration when doing things like diff or ediff
(setq svn-status-preserve-window-configuration t)

;; Use tramp
(require 'tramp)

;; Use cmake mode
(require 'cmake-mode)

;; Use lilypond mode
;(require 'lilypond-mode)

;; Use Opera as the generic URL browser
(setq browse-url-generic-program "uzbl-tabbed")

;; Ratpoison
(load-file "/usr/share/emacs/site-lisp/ratpoison.el")

;; Enable IDO mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; enable subword mode for C++
(add-hook 'c++-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for C
(add-hook 'c-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for python
(add-hook 'python-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for lisp
(add-hook 'lisp-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for java
(add-hook 'java-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for scala
(add-hook 'scala-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for groovy
(add-hook 'groovy-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable flyspell mode for latex
(add-hook 'latex-mode-hook
          '(lambda ()
             (flyspell-mode)))
;; enable visual word wrap mode for latex
(add-hook 'latex-mode-hook
          '(lambda ()
             (visual-line-mode)))

;; Make emacs correctly handle colors in shell mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Add Arduino ino files to c++-mode
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

;; Use pdflatex instead of latex
(setq latex-run-command "pdflatex --shell-escape")

;; Map C-c SPACE to fixup-whitespace
(global-set-key (kbd "C-c SPC") 'fixup-whitespace)
 
;; Map C-x C-F to find-file-other-window
(global-set-key (kbd "C-x C-S-f") 'find-file-other-window)

;; I prefer a horizontal split
(split-window-horizontally)

;; Map function keys to compile and debug
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'gdb)
;; Map function key to shell
(global-set-key (kbd "<f7>") 'shell)
;; Map function key to undo
(global-set-key (kbd "<f12>") 'undo)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Load a nice theme
(load-theme 'solarized-dark)
