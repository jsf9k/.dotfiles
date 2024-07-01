;;; jsf9k.el --- Provide some user-specific functionality

;;; Commentary:
;;;
;;; Code:

(require 'f)
(require 'yaml)

(defun jsf9k/install-pre-commit-dependencies ()
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
identify any Python-based linters that I would like to install
locally, and install those dependencies via pip.  That is
precisely what this function does."
  (interactive)
  (let (
        ;; This is the `repos' section of the pre-commit configuration
        ;; file, parsed from YML into an elisp data structure.
        (repos (gethash 'repos (yaml-parse-string(f-read-text ".pre-commit-config.yaml"))))
        ;; We will populate this hash table with keys equal to the
        ;; pre-commit repository URIs we're interested in and values
        ;; equal to the corresponding pip packages.
        (uri_to_pkg_map (make-hash-table :test 'equal))
        ;; The pip packages to be installed.  This list will be
        ;; populated as we go.
        (pip_pkgs (list))
        )
    ;; Populate uri_to_pkg_map
    (puthash "https://github.com/PyCQA/bandit" "bandit" uri_to_pkg_map)
    (puthash "https://github.com/psf/black-pre-commit-mirror" "black" uri_to_pkg_map)
    (puthash "https://github.com/PyCQA/flake8" "flake8" uri_to_pkg_map)
    (puthash "https://github.com/PyCQA/isort" "isort" uri_to_pkg_map)
    (puthash "https://github.com/pre-commit/mirrors-mypy" "mypy" uri_to_pkg_map)
    (puthash "https://github.com/asottile/pyupgrade" "pyupgrade" uri_to_pkg_map)
    (puthash "https://github.com/adrienverge/yamllint" "yamllint" uri_to_pkg_map)

    ;; Iterate over each repo specified in the pre-commit config file
    (mapc
     (lambda (repo_from_precommit_config)
       ;; Iterate over `uri_to_pkg_map'
       (maphash
        (lambda (uri pkg)
          ;; Does the URI for this repo match one of the ones in
          ;; `uri_to_pkg_map'?
          (if (string= (gethash 'repo repo_from_precommit_config) uri)
              ;; It does, so push the pip package (with the version
              ;; information specified in the pre-commit file) to
              ;; `pip_pkgs'.
              (progn
                (push (concat
                       pkg
                       "=="
                       (gethash 'rev repo_from_precommit_config))
                      pip_pkgs)
                ;; If the pre-commit config file specifies any
                ;; additional dependencies for the pre-commit hook,
                ;; then iterate over them and push them onto
                ;; `pip_pkgs' as well.
                (mapc
                 (lambda (hook)
                   (setq pip_pkgs (append (gethash 'additional_dependencies hook) pip_pkgs)))
                 (gethash 'hooks repo_from_precommit_config)))))
        uri_to_pkg_map))
     repos)

    ;; Use pip to install the dependencies gleaned from the pre-commit
    ;; config file
    (async-shell-command (concat "pip install " (mapconcat 'identity pip_pkgs " ")))))

(provide 'jsf9k)
;;; jsf9k.el ends here
