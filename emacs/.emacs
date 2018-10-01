;; Set up package installation
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;; Disable loading of "default.el" at startup
(setq inhibit-default-init t)

;; Turn off the blinking cursor
(blink-cursor-mode nil)

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
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Turn on semantic-mode and semantic-decoration-mode
(semantic-mode 1)
(global-semantic-decoration-mode t)

;; Use cscope
(require 'xcscope)

;; Use tramp
(require 'tramp)

;; Use cmake mode
(require 'cmake-mode)

;; Use lilypond mode
;;(require 'lilypond-mode)

;; Use chromium as the generic URL browser
(setq browse-url-generic-program "chromium")

;; Ratpoison
(require 'ratpoison)

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

;; enable subword mode for CMake
(add-hook 'cmake-mode-hook
          '(lambda ()
             (subword-mode)))

;; enable subword mode for javascript
(add-hook 'js-mode-hook
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

;; Add Arduino ino files to c++-mode
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

;; Use pdflatex instead of latex
(setq latex-run-command "pdflatex --shell-escape")

;; Load a nice theme
(load-theme 'solarized-dark t)
