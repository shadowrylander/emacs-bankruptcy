(initsplit-this-file bos (| "magit-" "git-timemachine-"))

(req-package magit
	     :commands magit-status
             :bind (("C-c g" . magit-status))
             :init
             (setq magit-auto-revert-mode nil)
	     :config
             (setq magit-auto-revert-mode t)
	     (setq magit-last-seen-setup-instructions "1.4.0"))

(req-package git-timemachine
	     :require magit
	     :bind ("C-c G" . git-timemachine)
	     :commands git-timemachine)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-auto-revert-mode t)
 '(magit-diff-arguments (quote ("--stat" "--no-ext-diff" "--ignore-all-space")))
 '(magit-diff-use-overlays nil))
