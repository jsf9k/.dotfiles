;;; jsf9k.el --- Provide some user-specific functionality

;;; Commentary:
;;;
;;; Code:

(require 'f)
(require 'projectile)
(require 'yaml)

(defvar jsf9k/projectile-pre-commit-uri-to-pkg-map
  (make-hash-table :test 'equal)
  "Hash table to associate pre-commit repositories with pip packages.

The hash table has keys equal to the pre-commit repository URIs
we're interested in and values equal to the corresponding pip
packages (e.g. https://github.com/adrienverge/yamllint and
yamllint, respectively).")

(defun jsf9k/projectile-install-pre-commit-dependencies ()
  "Install pip dependencies from current project's pre-commit config file.

I have a lot of projects that use
pre-commit (https://github.com/pre-commit/pre-commit).  I also
have a hook added to `projectile-after-switch-project-hook' that
automatically switches to the Python virtual environment with the
same name as the project.  The problem is that my linter
dependencies are defined in a pre-commit configuration file and
not in the pip files (usually requirements*.txt files) that
specify what pip packages are installed into my virtual
environment.  Thus I run into these sorts of problems:

- I'm editing a Python file and my editor wants to provide extra
  typing information, but it can't because the pip package mypy isn't
  installed in the local Python virtual environment.
- I'm editing a Python file and my editor wants to provide flake8
  warning and error information, but it can't because the pip package
  flake8 isn't installed in the local Python virtual environment.
- I'm editing a YML file and my editor wants to do some syntax
  checking with yamllint, but it can't because the pip package
  yamllint isn't installed in the local Python virtual environment.
- I'm editing a Python file and I know that black will want to make
  changes.  To save time I'd like to go ahead and run black against
  the file without leaving my editor.  I can't do that because black
  isn't installed in the local Python virtual environment.

The solution is to parse the pre-commit configuration file,
identify any Python-based linters whose pip packages I would like
to install locally, and install those dependencies via pip.  That
is precisely what this function does.  The linters of interest
are identified in the variable
`jsf9k/projectile-pre-commit-uri-to-pkg-map'."
  (interactive)
  (let (
        ;; This is the `repos' section of the pre-commit configuration
        ;; file, parsed from YML into an elisp data structure.
        (repos (gethash
                'repos
                (yaml-parse-string(f-read-text (concat
                                                (projectile-project-root)
                                                ".pre-commit-config.yaml")))))
        ;; The pip packages to be installed.  This list will be
        ;; populated as we go.
        (pip-pkgs (list))
        )
    ;; Iterate over each repo specified in the pre-commit config file
    (mapc
     (lambda (repo_from_precommit_config)
       ;; Iterate over `jsf9k/projectile-pre-commit-uri-to-pkg-map'
       (maphash
        (lambda (uri pkg)
          ;; Does the URI for this repo match one of the ones in
          ;; `jsf9k/projectile-pre-commit-uri-to-pkg-map'?
          (if (string= (gethash 'repo repo_from_precommit_config) uri)
              ;; It does, so push the pip package (with the version
              ;; information specified in the pre-commit file) to
              ;; `pip-pkgs'.
              (progn
                (push (concat
                       pkg
                       "=="
                       (gethash 'rev repo_from_precommit_config))
                      pip-pkgs)
                ;; If the pre-commit config file specifies any
                ;; additional dependencies for the pre-commit hook,
                ;; then iterate over them and push them onto
                ;; `pip-pkgs' as well.
                (mapc
                 (lambda (hook)
                   (setq pip-pkgs
                         (append (gethash 'additional_dependencies hook)
                                 pip-pkgs)))
                 (gethash 'hooks repo_from_precommit_config)))))
        jsf9k/projectile-pre-commit-uri-to-pkg-map))
     repos)

    ;; Use pip to install the dependencies gleaned from the pre-commit
    ;; config file, remembering to shell-quote as necessary.
    (async-shell-command (concat "pip install "
                                 (mapconcat 'shell-quote-argument
                                            pip-pkgs " ")))))

(provide 'jsf9k)
;;; jsf9k.el ends here
