;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
(setq inhibit-default-init t)

;; Add our lisp directory to the load path
(add-to-list 'load-path "~/.emacs.d/lisp")

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; Turn of the blinking cursor
(blink-cursor-mode 0)

;; enable visual feedback on selections
;(setq transient-mark-mode t)

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

;; Use "M-x list-faces-display" to see the current colors.
(set-cursor-color "green")
(set-foreground-color "#FFFFFF")
(set-background-color "#111111")
;(set-face-background 'mode-line "#D8A315")

;; Have ediff split windows horizontally
(setq ediff-split-window-function 'split-window-horizontally)

;; Use cscope
(require 'xcscope)

;; Use psvn
;(require 'psvn)

;; Try to preserve the window configuration when doing things like diff or ediff
(setq svn-status-preserve-window-configuration t)

;; Use tramp
(require 'tramp)

;; Use cmake mode
(require 'cmake-mode)

;; Use lilypond mode
(require 'lilypond-mode)

;; Use pdflatex instead of latex
(setq latex-run-command "pdflatex")

;; Use Opera as the generic URL browser
(setq browse-url-generic-program "uzbl-tabbed")

;; Ratpoison
(load-file "/usr/local/share/emacs/site-lisp/ratpoison.el")

;; Map function keys to compile and debug
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'gdb)
;; Map function key to shell
(global-set-key (kbd "<f7>") 'shell)
;; Map function key to undo
(global-set-key (kbd "<f12>") 'undo)
