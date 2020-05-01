;; This config is only for Emacs 24 or greater
(when
    (< emacs-major-version 24)
    (error (message "Emacs version 24 or greater is required!")))

(defun load-file (file)
  (interactive "f")
  (load-file (expand-file-name file "~/.emacs.d")))


;; Early UI tweaks

(toggle-scroll-bar -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq exec-path
    (append exec-path '(
	"/users/victorvelechosky/Library/Python/3.7/bin"
	"/Users/victorvelechosky/.cargo/bin")))
			

;; Automatic package installation

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(package-refresh-contents)
; Packages
(setq package-list
    '(evil projectile helm helm-projectile helm-swoop doom-themes lsp-mode company))
; Activate all the packages
(package-initialize)
; Fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))
; Install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Evil mode

(evil-mode 1)

(with-eval-after-load 'helm
    (define-key helm-map (kbd "<ESC> <ESC>") 'helm-keyboard-quit))

;; Company

(add-hook 'after-init-hook 'global-company-mode)

;; Projectile
(require 'projectile)
(defun add-to-map(keys func)
  "Add a keybinding in evil mode from keys to func."
  (define-key evil-normal-state-map (kbd keys) func))
(add-to-map "<SPC>" nil)
(require 'helm)
(add-to-map "<SPC> f e" (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
(add-to-map "<SPC> f f" 'helm-find-files)
(add-to-map "<SPC> f s" 'save-buffer)
(add-to-map "<SPC> p p" 'helm-projectile-switch-project)
(add-to-map "<SPC> p f" 'helm-projectile-find-file)
(add-to-map "<SPC> p F" 'helm-projectile-find-file-in-known-projects)
(add-to-map "<SPC> p s" 'helm-projectile-ag)
(add-to-map "<SPC> s s" 'helm-swoop)
(add-to-map "<SPC> w h" 'evil-window-left)
(add-to-map "<SPC> w j" 'evil-window-down)
(add-to-map "<SPC> w k" 'evil-window-up)
(add-to-map "<SPC> w l" 'evil-window-right)
(add-to-map "<SPC> w /" 'evil-window-vsplit)
(add-to-map "<SPC> w ?" 'evil-window-split)
(add-to-map "<SPC> w d" 'evil-window-delete)
(add-to-map "<SPC> b d" 'kill-this-buffer)
(add-to-map "<SPC> b f" 'helm-buffers-list)
(add-to-map "<SPC> b b" 'next-buffer)
(add-to-map "<SPC> b B" 'previous-buffer)
(add-to-map "<SPC> q q" 'kill-emacs)
(add-to-map "<SPC> q r" 'kill-emacs)
(add-to-map "<SPC> b l" 'helm-mini)
(add-to-map "<SPC> y"   'helm-show-kill-ring)
(add-to-map "<SPC> '"   'shell)
(add-to-map "<SPC> h"   'helm-command-prefix-key)
(add-to-map "<SPC> <SPC>"   'execute-extended-command)
(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)
(projectile-mode +1)

;; Helm ;;

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))
(setq helm-split-window-in-side-p           t ; Open helm buffer inside current window
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)
(helm-mode 1)
(require 'helm-projectile)
(helm-projectile-on)
(setq helm-ff-DEL-up-one-level-maybe 'true)

;; Theme

(load-theme 'doom-one t)
(add-to-list 'default-frame-alist
    '(font . "Menlo-15"))

;; Don't touch!!!

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (doom-themes helm-swoop helm-projectile helm projectile evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Rust

(add-hook 'rust-mode-hook
      (lambda () (setq indent-tabs-mode nil)))
