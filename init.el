(toggle-scroll-bar -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
  
;; AUTOMATIC PACKAGE INSTALLATION ;;

(require 'package)

(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(add-to-list 'load-path "~/.emacs.d/site-lisp/")

; list the packages you want
(setq package-list
    '(evil projectile helm helm-projectile helm-swoop doom-themes haskell-mode))

; activate all the packages
(package-initialize)

;fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; EVIL MODE ;;

(evil-mode 1)

;; PROJECTILE ;;

(require 'projectile)

(global-unset-key (kbd "C-c p"))

(defun add-to-map(keys func)
  "Add a keybinding in evil mode from keys to func."
  (define-key evil-normal-state-map (kbd keys) func)
  (define-key evil-motion-state-map (kbd keys) func))

(add-to-map "<SPC>" nil)

(require 'helm)

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
(add-to-map "<SPC> b d" 'kill-buffer)
(add-to-map "<SPC> b b" 'next-buffer)
(add-to-map "<SPC> b B" 'previous-buffer)
(add-to-map "<SPC> q q" 'kill-emacs)
(add-to-map "<SPC> b l" 'helm-mini)
(add-to-map "<SPC> y"   'helm-show-kill-ring)
(add-to-map "<SPC> '"   'shell)
(add-to-map "<SPC> h"   'helm-command-prefix-key)
(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)

(projectile-mode +1)

;; HELM CONFIG ;;
;; (global-unset-key (kbd "C-s"))
;; (global-set-key (kbd "C-s s") 'helm-swoop)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

(require 'helm-projectile)
(helm-projectile-on)

;; USER INTERFACE ;;

;; Theme
(load-theme 'doom-one t)

(add-to-list 'default-frame-alist
    '(font . "Consolas-10"))
