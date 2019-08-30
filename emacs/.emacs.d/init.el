;; I stole a lot of this from Bozhidar Batsov's personal
;; configuration: https://github.com/bbatsov/emacs.d

;; Set up package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; Keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)

;; Update the package metadata if the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

;; Identity information (name and email)
(load "~/.emacs.d/identity")

;; Always load newest byte code
(setq load-prefer-newer t)

;; Reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; Warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(defconst my-savefile-dir (expand-file-name "savefile" user-emacs-directory))

;; Create the savefile dir if it doesn't exist
(unless (file-exists-p my-savefile-dir)
  (make-directory my-savefile-dir))

;; Don't show the menu, tool, or scroll bars
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Display the time and date
(setq display-time-format "%I:%M%p %a %b %d")
(display-time-mode 1)

;; Turn off annoyances: the blinking cursor, the bell, the init
;; screen, and the splash screen
(blink-cursor-mode nil)
(setq ring-bell-function 'ignore
      inhibit-default-init t
      inhibit-splash-screen t)

;; Nice scrolling
;; (setq scroll-margin 0
;;       scroll-conservatively 100000
;;       scroll-preserve-screen-position 1)

;; Mode line settings
(column-number-mode t)
(line-number-mode t)
(size-indication-mode t)

;; Enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Turn on font-lock mode
;; (when (fboundp 'global-font-lock-mode)
;;   (global-font-lock-mode t))

;; Show a more useful frame title, that shows either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Enable visual feedback on selections
;; (setq transient-mark-mode t)

;; Use spaces instead of tabs for indent.
(setq-default indent-tabs-mode nil)
;; Set default tab width for all buffers
(setq-default tab-width 4)

;; Always end a file with a newline
(setq require-final-newline t)

;; Store all backup and autosave files in the /tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Revert buffers automatically when underlying files are changed
;; externally
(global-auto-revert-mode t)

;; (prefer-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)

;; Use chromium as the generic URL browser
(setq browse-url-generic-program "chromium")

;; Install use-package if necessary, then set it up
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-verbose t)

(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

(require 'dired-x)

;; Enable IDO mode
(use-package ido
  :ensure t
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  :config
  (ido-mode 1))
(use-package ido-vertical-mode
  :ensure t
  :config
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  (ido-vertical-mode 1))

;; Turn on semantic-mode and semantic-decoration-mode
(use-package semantic
  :ensure t
  :config
  (semantic-mode 1)
  (global-semantic-decoration-mode t))

;; Tramp
(use-package tramp
  :ensure t)

;; Ratpoison
(use-package ratpoison
  :load-path "/usr/share/emacs/site-lisp")

;; magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;; git-timemachine
(use-package git-timemachine
  :ensure t)

;; projectile
(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-completion-system 'ido)
  :config
  (projectile-mode 1))

;; rainbow-mode
(use-package rainbow-mode
  :ensure t
  :hook (prog-mode text-mode))

;; subword-mode
(use-package subword
  :hook (prog-mode . subword-mode))

;; flyspell
(use-package flyspell
  :hook ((prog-mode . flyspell-prog-mode)
         (text-mode . flyspell-mode)))

;; flyspell-correct-ido
(use-package flyspell-correct
  :ensure t
  :config
  (require 'flyspell-correct-ido))

;; yaml-mode
(use-package yaml-mode
  :ensure t)

;; markdown-mode
(use-package markdown-mode
  :ensure t)

;; company-mode
(use-package company
  :ensure t
  :config
  (global-company-mode)
  (add-to-list 'company-backends 'company-capf))

;; flycheck-mode
(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode))

;; undo-tree
(use-package undo-tree
  :ensure t
  :hook ((prog-mode . undo-tree-mode)
         (text-mode . undo-tree-mode)))

;; electric-pair-mode
(electric-pair-mode)

;; anaconda
(use-package anaconda-mode
  :hook ((python-mode)
         (python-mode . anaconda-eldoc-mode)))

;; restclient
(use-package restclient
  :ensure t)

;; ansible
(use-package ansible
  :ensure t)

;; terraform-mode
(use-package terraform-mode
  :ensure t)

;; company plugins
(use-package company-anaconda
  :ensure t
  :config
  (add-to-list 'company-backends 'company-anaconda))
(use-package company-ansible
  :ensure t
  :config
  (add-to-list 'company-backends 'company-ansible))
(use-package company-math
  :ensure t
  :config
  (add-to-list 'company-backends 'company-math))
(use-package company-restclient
  :ensure t
  :config
  (add-to-list 'company-backends 'company-restclient))
(use-package company-terraform
  :ensure t
  :config
  (add-to-list 'company-backends 'company-terraform))
(use-package company-web
  :ensure t
  :config
  (add-to-list 'company-backends 'company-web))

;; yasnippet
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))
(use-package yasnippet-snippets
  :ensure t)

;; smex
(use-package smex
  :ensure t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command))
  :config
  (smex-initialize))

;; ace-window
(use-package ace-window
  :ensure t
  :bind ("M-o" . ace-window))

;; pdf-tools
(use-package pdf-tools
  :ensure t
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install))

;; mustache-mode
(use-package mustache-mode
  :ensure t)

;; docker-compose-mode and dockerfile-mode
(use-package docker-compose-mode
  :ensure t)
(use-package dockerfile-mode
  :ensure t)

;; winner mode
(winner-mode 1)

;; Enable visual word wrap mode for text modes
(add-hook 'text-mode-hook
          '(lambda ()
             (visual-line-mode 1)))

(setq enable-recursive-minibuffers t)

;; Add Arduino ino files to c++-mode
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

;; Use pdflatex instead of latex
(setq latex-run-command "pdflatex --shell-escape")

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

(set-frame-font "Inconsolata 12" nil t)

(server-start)
