;;; Load each thing from packages.d
(setq load-prefer-newer t)
(setq gc-cons-threshold 8000000)

(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

(require 'package)

(setq package-archives
      '(("melpa-unstable" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" .  "https://elpa.gnu.org/packages/")))

(setq tls-trustcheck t
      gnutls-verify-error t
      gnutls-trustfiles '("/etc/ssl/certs/ca-certificates.crt"))

(add-to-list 'package-directory-list "~/.nix-profile/share/emacs/site-lisp/elpa")

(defun require-package (package)
  "refresh package archives, check package presence and install if it's not installed"
  (if (null (require package nil t))
      (progn (let* ((ARCHIVES (if (null package-archive-contents)
                                  (progn (package-refresh-contents)
                                         package-archive-contents)
                                package-archive-contents))
                    (AVAIL (assoc package ARCHIVES)))
               (if AVAIL
                   (package-install package)))
             (require package))))



(let ((inhibit-message t)
      (inhibit-redisplay t)
      (file-name-handler-alist nil))

  (package-initialize)

  (require-package 'auto-compile)
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode)

  (require-package 'req-package)
  (require 'req-package)
  (setq use-package-always-ensure t)

  (req-package load-dir
    :ensure t
    :force true
    :init
    (setq force-load-messages nil)
    (setq load-dir-debug nil)
    (setq load-dir-recursive t)

    :config

    (load-dir-one "~/.emacs.d/packages.d/"))

  (req-package-finish)
  )

(put 'set-goal-column 'disabled nil)



(setq gc-cons-threshold 80000000)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (load-dir req-package initsplit el-get))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
