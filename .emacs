(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahs-idle-interval 0.2)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (material)))
 '(custom-safe-themes
   (quote
    ("e97dbbb2b1c42b8588e16523824bc0cb3a21b91eefd6502879cf5baa1fa32e10" default)))
 '(gnutls-trustfiles
   (quote
    ("/etc/ssl/certs/ca-certificates.crt" "/etc/pki/tls/certs/ca-bundle.crt" "/etc/ssl/ca-bundle.pem" "/usr/ssl/certs/ca-bundle.crt" "C:\\emacs\\cacert.pem")))
 '(projectile-project-root-files
   (quote
    ("rebar.config" "project.clj" "build.boot" "SConstruct" "pom.xml" "build.sbt" "gradlew" "build.gradle" "Gemfile" "requirements.txt" "setup.py" "tox.ini" "package.json" "gulpfile.js" "Gruntfile.js" "bower.json" "composer.json" "Cargo.toml" "mix.exs" "stack.yaml" "TAGS" "GTAGS" ".projectile")))
 '(save-place t nil (saveplace))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(yascroll:delay-to-hide nil)
 '(yascroll:scroll-bar (quote (right-fringe right-fringe text-area))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "PragmataPro" :foundry "outline" :slant normal :weight normal :height 83 :width normal))))
 '(yascroll:thumb-fringe ((t (:background "slateblue" :foreground "slateblue" :width condensed)))))

;;----------------------------------------
;; HELM MODE
;;----------------------------------------
(require 'helm-config)

(setq helm-split-window-in-side-p t
      helm-ff-file-name-history-use-recentf t)
(setq helm-M-x-fuzzy-match t)
(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-i") 'helm-multi-files)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-m") 'helm-occur)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z



;;----------------------------------------
;; USEPACKAGE
;;----------------------------------------
(require 'use-package)



;;----------------------------------------
;; ETC
;;----------------------------------------
(use-package etc-settings
  :init
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (setq visible-bell t)
  )


;;----------------------------------------
;; NEOTREE
;;----------------------------------------
(global-set-key [f8] 'neotree-toggle)


;;----------------------------------------
;; CIDER KEYBINDING
;;----------------------------------------
(defun cider-figwheel-repl ()
  (interactive)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/start-figwheel!) ; idempotent
             (figwheel-sidecar.repl-api/cljs-repl)")
    (cider-repl-return)))


(use-package cider
  :init
  (require 'cider)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)

  :bind (:map
	 cider-mode-map
	 ("C-c C-n" . cider-repl-set-ns)
	 ("M-l" . cider-repl-set-ns)
	 ("C-3" . cider-eval-last-sexp)
	 ("C-'" . clojure-align)
	 
	 :map
	 cider-repl-mode-map
	 ("C-c C-f" . cider-figwheel-repl)
	 )
  )


;;----------------------------------------
;; SMARTPAREN
;;----------------------------------------

;;(define-key clojure-mode-map (kbd "<tab>") 'helm-execute-persistent-action)

(use-package smartparens
  :init
  (require 'smartparens-config)
  (dolist (hook '(clojure-mode-hook
		  clojurescript-mode-hook
		  emacs-lisp-mode-hook)
		)
    (add-hook hook #'smartparens-mode)
    )
  :bind (:map smartparens-mode-map
	      ("C-M-a" . sp-beginning-of-sexp)
	      ("C-M-e" . sp-end-of-sexp)
	      ("C-S-u" . sp-raise-sexp)
	      ("C-0" . sp-forward-slurp-sexp)
	      ("C-9" . sp-backward-slurp-sexp)
	      ("M-<right>" . sp-forward-barf-sexp)
	      ("C-<left>"  . sp-backward-slurp-sexp)
	      ("M-<left>"  . sp-backward-barf-sexp)
	      ("C-M-n" . sp-next-sexp)
	      ("C-M-p" . sp-previous-sexp)
	      )
  )




;;----------------------------------------
;; RAINBOW DELIMETER
;;----------------------------------------
;; (dolist (hook '(clojure-mode-hook
;; 		clojurescript-mode-hook
;; 		emacs-lisp-mode-hook))
;;   (add-hook hook #'rainbow-delimiters-mode))


;;----------------------------------------
;; EVAL SEXP FU
;;----------------------------------------
;;(require 'cider-eval-sexp-fu)


;;----------------------------------------
;; WRAP REGION MODE
;;----------------------------------------
(wrap-region-mode t)

 

;;----------------------------------------
;; DESKTOP
;;----------------------------------------



;;----------------------------------------
;; PROJECTILE
;;----------------------------------------
(use-package projectile
  :init
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on)
  
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching t)

  :bind (("M-o" . helm-projectile-find-file))
  )


;;----------------------------------------
;; Expand Region
;; Can't edit without this
;;----------------------------------------
(use-package expand-region
  :init
  (require 'expand-region)
  :bind (("C-2" . er/expand-region)
	 ("C-q" . er/expand-region))
  )


;;----------------------------------------
;; Line spacing
;;----------------------------------------
(setq-default line-spacing 2)
(visual-line-mode)


;;----------------------------------------
;; YAScroll
;;----------------------------------------
(global-yascroll-bar-mode 1)
(scroll-bar-mode -1)


;;----------------------------------------
;; FILL COLUMN INDICATOR
;;----------------------------------------
(use-package fill-column-indicator
  :init
  (require 'fill-column-indicator)
  (fci-mode t)
  )


;;----------------------------------------
;; YAS
;;----------------------------------------
(use-package yas
  :init
  (require 'yasnippet)
  (yas-global-mode 1)
  )


;;----------------------------------------
;; AUTO HIGHLIGHT
;;----------------------------------------
(use-package auto-highlight-symbol
  :init
  (require 'auto-highlight-symbol)
  (global-auto-highlight-symbol-mode t)
  )


;;----------------------------------------
;; MULTI ESHELL
;;----------------------------------------
(use-package multi-eshell
  :init
  (add-to-list 'load-path
	       "C:\\Users\\popop\\AppData\\Roaming\\.emacs.d\\libs")
  (require 'multi-eshell)
  )


