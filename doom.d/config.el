;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Michael Utz"
      user-mail-address "michael@theutz.com")

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
(setq doom-font (font-spec :family "Haskplex Nerd" :size 14 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "VictorMono Nerd Font Mono" :size 16))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-palenight)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

(setq +org-capture-todo-file "inbox.org")

(after! evil-snipe
  (setq evil-snipe-spillover-scope 'visible))

(after! org
  (add-hook 'org-mode-hook
            #'mixed-pitch-mode)
  (custom-set-faces!
    '(org-document-title :height 1.3))
  (push '("b" "Bookmark (Clipboard)" entry (file+headline "bookmarks.org" "Bookmarks")
          "** %(org-cliplink-capture)\n:PROPERTIES:\n:TIMESTAMP: %t\n:END:%?\n" :empty-lines 1 :prepend t) org-capture-templates)
  (setq org-clock-idle-time 5))

(setq-default line-spacing 10)

(defvar prev-line-spacing line-spacing
  "Previous value of line spacing before it was turned off.")

(defun set-line-spacing (arg)
  "Set line spacing. If `arg' is a lambda function, it will be passed
   a single argument for the current value. Otherwise, it should be a
   number greater than or equal to `0'. If an invalid value is given,
   it will be reset to the default value."
  (setq prev-line-spacing line-spacing
        line-spacing (cond ((functionp arg) (funcall arg line-spacing))
                           ((numberp arg) (if (< 0 arg) arg nil))
                           ((eq arg nil) nil)
                           (t (default-value 'line-spacing)))))

(defun line-spacing-off ()
  "Turn line spacing off."
  (interactive)
  (set-line-spacing nil))

(defun line-spacing-on ()
  "Turn line spacing on."
  (interactive)
  (set-line-spacing prev-line-spacing))

(defun line-spacing-p ()
  "Returns `t' if line spacing is on."
  (not (eq line-spacing nil)))

(defun toggle-line-spacing ()
  "Toggle line spacing."
  (interactive)
  (if (line-spacing-p)
      (line-spacing-off)
    (line-spacing-on)))

(map! :leader :desc "Line spacing" :n "t h" #'toggle-line-spacing)

(add-hook 'vterm-mode-hook #'line-spacing-off)

(after! magit
  (let '(sections '(remote local))
    (dolist (section sections)
      (add-to-list 'magit-section-initial-visibility-alist `(,section . hide)))))

(add-to-list '+lookup-provider-url-alist '("Kagi" "https://kagi.com/search?q=%s"))

(map! :localleader :mode 'org-mode :n "d =" 'org-timestamp-up)
(map! :localleader :mode 'org-mode :n "d -" 'org-timestamp-down)

(add-to-list 'auto-mode-alist '("/authinfo\\.gpg\\'" . authinfo-mode))

(after! mu4e
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail
        mu4e-update-interval (* 60 5)))

(setq +lookup-open-url-fn #'+lookup-xwidget-webkit-open-url-fn)
(after! dash-docs
  (setq dash-docs-browser-func #'+lookup-xwidget-webkit-open-url-fn))

(after! mu4e
  (setq mu4e-maildir-shortcuts '(
                                 (:maildir "/INBOX" :key ?i)
                                 (:maildir "/Archive" :key ?a)
                                 (:maildir "/Drafts" :key ?d)
                                 (:maildir "/Sent" :key ?s)
                                 (:maildir "/Trash" :key ?t))))

(use-package! super-save
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t
        auto-save-default nil)
  (add-to-list 'super-save-hook-triggers 'find-file-hook))

(map! :leader :desc "Switch workspace" :n "TAB TAB" #'+workspace/switch-to)
(map! :leader :desc "Display tab bar" :n "TAB ." #'+workspace/display)

(defun search-org-manual-menu ()
  (interactive)
  (org-info)
  (call-interactively 'Info-menu))
(map! :leader :n "h z" #'search-org-manual-menu)

(defun org-kill-subtree-contents ()
  "Clear all contents of a subtree, preserving only the heading."
  (interactive)
  (let ((register "r"))
    (point-to-register register)
    (org-mark-subtree)
    (forward-line)
    (kill-region (region-beginning) (region-end))
    (jump-to-register register)))
(map! :localleader :map org-mode-map :n "s x" #'org-kill-subtree-contents)
