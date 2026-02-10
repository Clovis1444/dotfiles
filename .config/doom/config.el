;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;;
;; [FONT]
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16))
;;
;; [THEME]
(setq doom-theme 'catppuccin)
;;
;; [GENERAL]
(setq display-line-numbers-type 'relative)
(drag-stuff-global-mode t)
(drag-stuff-define-keys)
;;
;; [MODELINE]
;; Font size
;; (custom-set-faces!
;;   '(mode-line :family "JetBrainsMono Nerd Font" :height 1.1)
;;   '(mode-line-inactive :family "JetBrainsMono Nerd Font" :height 1.1))
;; Whether display icons in the mode-line.
;; While using the server mode in GUI, should set the value explicitly.
(setq doom-modeline-icon t)
;; Whether display the icon for `major-mode'. It respects option `doom-modeline-icon'.
(setq doom-modeline-major-mode-icon t)
;; Whether display the buffer encoding.
(setq doom-modeline-buffer-encoding t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
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
