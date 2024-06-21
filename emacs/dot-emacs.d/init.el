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
(load "~/.emacs_identity")

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

(use-package avy
  :ensure t
  :bind (("M-j" . avy-goto-char-timer))
  ;; :bind (("s-." . avy-goto-word-or-subword-1)
  ;;        ("s-," . avy-goto-char)
  ;;        ("C-c ." . avy-goto-word-or-subword-1)
  ;;        ("C-c ," . avy-goto-char)
  ;;        ("M-g f" . avy-goto-line)
  ;;        ("M-g w" . avy-goto-word-or-subword-1))
  :config
  (setq avy-background t))

;; magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;; git-timemachine
(use-package git-timemachine
  :ensure t)

;; projectile
;; (use-package projectile
;;   :ensure t
;;   :bind-keymap
;;   ("C-c p" . projectile-command-map)
;;   :init
;;   (setq projectile-completion-system 'ido)
;;   :config
;;   (projectile-mode 1))

;; rainbow-mode
(use-package rainbow-mode
  :ensure t
  :hook (prog-mode text-mode))

;; subword-mode
(use-package subword
  :hook (prog-mode . subword-mode))

;; yaml-mode
(use-package yaml-mode
  :ensure t)

;; markdown-mode
(use-package markdown-mode
  :ensure t)

;; minad stack
(use-package vertico
  :ensure t
  :init
  (vertico-mode))
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x C-b" . consult-buffer)              ;; orig. list-buffers
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element
  )
(use-package consult-flycheck
  :ensure t)
(use-package consult-tex
  :ensure t)
(use-package orderless
  :ensure t
  :init
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package marginalia
  :ensure t
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))
(use-package cape
  :ensure t)
;; Use Company backends as Capfs.
(use-package company-ansible
  :ensure t)
(use-package company-terraform
  :ensure t)
;; (setq-local completion-at-point-functions
;;   (mapcar #'cape-company-to-capf
;;     (list #'company-ansible #'company-terraform)))
(use-package embark
  :ensure t
  :bind (("M-." . embark-act)))
(use-package embark-consult
  :ensure t)

;; jinx spellchecker
(use-package jinx
  :ensure t
  ;; Enable jinx globally
  :hook (emacs-startup . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages)))

;; flycheck-mode
(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode))

;; undo-tree
(use-package undo-tree
  :ensure t
  :hook ((prog-mode . undo-tree-mode)
         (text-mode . undo-tree-mode)))
;; Prevent undo tree files from polluting your git repo
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
;; Or, just don't persist undo history at all
;; (setq undo-tree-auto-save-history nil)

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
(use-package ansible-doc
  :ensure t)
(add-hook 'yaml-mode-hook #'ansible-doc-mode)

;; terraform-mode
(use-package terraform-mode
  :ensure t)

;; (use-package company
;;   :ensure t
;;   :config
;;   (add-to-list 'company-backends 'capf))
;; company plugins
;; (use-package company-anaconda
;;   :ensure t
;;   :config
;;   (add-to-list 'company-backends 'company-anaconda))
;; (use-package company-ansible
;;   :ensure t)
;;  :config
;;  (add-to-list 'company-backends 'company-ansible))
;; (use-package company-math
;;   :ensure t
;;   :config
;;   (add-to-list 'company-backends 'company-math))
;; (use-package company-restclient
;;   :ensure t
;;   :config
;;   (add-to-list 'company-backends 'company-restclient))
;; (use-package company-terraform
;;   :ensure t)
;;  :config
;;  (add-to-list 'company-backends 'company-terraform))
;; (use-package company-web
;;   :ensure t
;;   :config
;;   (add-to-list 'company-backends 'company-web))

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

;; Switch to sudo on an open file
(use-package sudo-edit
  :ensure t)

;; Major mode for SystemD unit files
(use-package systemd
  :ensure t)

;; winner mode
(winner-mode 1)

;; org-mode
(use-package org
  :ensure t)
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Enable visual word wrap mode for text modes
(add-hook 'text-mode-hook
          '(lambda ()
             (visual-line-mode 1)))

;; lorem-ipsum
(use-package lorem-ipsum
  :ensure t)

(setq enable-recursive-minibuffers t)

;; Add Arduino ino files to c++-mode
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

;; Use pdflatex instead of latex
(setq latex-run-command "pdflatex --shell-escape")

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

(set-frame-font "Sauce Code Pro Nerd Font 11" nil t)

(server-start)
