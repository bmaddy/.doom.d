;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Brian Maddy"
      user-mail-address "brian@brianmaddy.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "Fira Code" :size 19 :weight 'semi-light))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tomorrow-day)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")
(setq org-directory "~/Dropbox/org/")

;; launch emacs maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; change the localleader key
;; https://github.com/doomemacs/doomemacs/issues/4242#issuecomment-724356280
(setq evil-snipe-override-evil-repeat-keys nil)
(setq doom-localleader-key ",")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! cider
  (set-popup-rules!
    '(("^\\*cider-repl"
       :ignore t
       ;; :side right
       ;; :width 100
       ;; :quit nil
       ;; :ttl nil
       ))))

(add-hook 'lisp-mode-hook #'evil-cleverparens-mode)
(add-hook 'clojure-mode-hook #'evil-cleverparens-mode)

;; (use-package! ediprolog
;;   ;; :mode ("\\.\\(pl\\|pro\\|lgt\\)" . prolog-mode)
;;   :mode "\\.\\(pl\\|pro\\|lgt\\)"
;;   :config

;;   ;; (setq ediprolog-system 'swi)
;;   ;; (setq ediprolog-program "/usr/bin/swipl")

;;   ;; (setq ediprolog-system 'swi)
;;   ;; (setq ediprolog-program "/snap/bin/swi-prolog.swipl")

;;   ;; works, but has ^M after each line
;;   (setq ediprolog-program "docker")
;;   (setq ediprolog-program-switches '("run" "-v" ".:/mnt" "-v" "/tmp:/tmp" "-e" "TERM=dumb" "-it" "mjt128/scryer-prolog"))

;;   )

(use-package! prolog
  ;; :mode "\\.\\(pl\\|pro\\|lgt\\)"
  ;; :mode ("\\.\\(pl\\|pro\\|lgt\\)" . prolog-mode)
  :mode ("\\.pl\\'" . prolog-mode)
  :config
  (require 'ediprolog)

  ;; works, but has ^M after each line
  (setq ediprolog-program "docker")
  (setq ediprolog-program-switches '("run" "-v" ".:/mnt" "-v" "/tmp:/tmp" "-e"
                                     "TERM=dumb" "-it" "mjt128/scryer-prolog"))

  (defun pl-kill-prolog ()
    (:documentation (documentation 'ediprolog-kill-prolog))
    (interactive)
    (ediprolog-dwim 0))
  (defun pl-consult-buffer ()
    (:documentation (documentation 'ediprolog-consult))
    (interactive)
    (ediprolog-consult))
  (defun pl-consult-buffer-new ()
    (:documentation (documentation 'ediprolog-consult))
    (interactive)
    (ediprolog-consult t))
  (defun pl-toplevel ()
    (:documentation (documentation 'ediprolog-toplevel))
    (interactive)
    (ediprolog-dwim 7))
  (defun pl-consult-query ()
    "Consults buffer then eval query."
    (interactive)
    (ediprolog-dwim '(4)))
  (defun pl-consult-query-new ()
    "Consults buffer in new process then eval query."
    (interactive)
    (ediprolog-dwim '(16)))
  (defun pl-query ()
    (:documentation (documentation 'ediprolog-query))
    (interactive)
    (ediprolog-query))

  (map! :map prolog-mode-map
        :n ", e RET" #'ediprolog-dwim
        :n ", e b" #'ediprolog-consult
        :n ", e B" #'pl-consult-buffer-new
        :n ", e e" #'pl-query
        :n ", e q" #'pl-consult-query
        :n ", e Q" #'pl-consult-query-new
        :n ", r k" #'pl-kill-prolog
        :n ", r t" #'pl-toplevel
        :n ", e c" #'ediprolog-remove-interactions)
  )

(after! org
  ;; track when todo items are closed
  (setq org-log-done 'time)
  ;; this doesn't seem to work
  ;; don't wrap lines
  ;; (+word-wrap-mode 0)
  ;; this doesn't seem to work
  ;; close org trees by default
  ;; (org-cycle-global 1)
  )

(add-hook! org-mode
  (org-cycle-global 1))
