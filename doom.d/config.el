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
      doom-variable-pitch-font (font-spec :family "Inter" :size 14 :weight 'light)
      doom-serif-font (font-spec :family "ETBembo" :size 14 :weight 'regular))

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

(after! evil-snipe
  (setq evil-snipe-spillover-scope 'visible))

(after! org
  (require 'org-faces)

  ;; Hide emphasis markers on formatted text
  (setq org-hide-emphasis-markers t)

  ;; Resize org headings
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font doom-font :weight 'medium :height (cdr face)))

  (dolist (face '(org-level-1 org-level-2 org-level-3))
    (set-face-attribute face nil :weight 'semibold))

  ;; Make the document title a little bigger
  (set-face-attribute 'org-document-title nil :font doom-font :weight 'bold :height 1.3)

  ;; Make sure certain org faces use the fixed-pitch face when variable-pitch-mode is on
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

  (push '("b" "Bookmark" entry (file+headline "bookmarks.org" "Bookmarks")
          "** %(org-cliplink-capture)\n:PROPERTIES:\n:TIMESTAMP: %t\n:END:%?\n" :empty-lines 1 :prepend t) org-capture-templates)
  (setq org-clock-idle-time 5))

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

(map! :leader :desc "News feeds (RSS)" :n "o n" #'elfeed)
(add-hook 'elfeed-search-mode-hook #'elfeed-update)

(setq +lookup-open-url-fn #'+lookup-xwidget-webkit-open-url-fn
      browse-url-browser-function #'+lookup-xwidget-webkit-open-url-fn
      browse-url-secondary-browser-function #'browse-url-default-browser)
(map! :leader :desc "xWidget tabs" :n "o x" #'evil-collection-xwidget-webkit-search-tabs)
(map! :leader :desc "Web page" :n "o w" #'xwidget-webkit-browse-url)

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

(setq default-input-method "turkish-alt-postfix")

(map! :leader :desc "Calendar" :n "o c" #'=calendar)

(use-package! osx-plist)

(use-package! org-caldav
  :config
  (setq org-caldav-url "https://caldav.fastmail.com/dav/calendars/user/michael@theutz.com/"
        org-caldav-calendars `((:calendar-id "e8b895a3-6fd2-42cd-9589-4c8c6bcab38f"
                                :files (,(expand-file-name "family.org" org-directory))
                                :inbox ,(expand-file-name "from_family.org" org-directory))
                               (:calendar-id "253b8208-fdd2-4821-bc6c-23852c6529ce"
                                :files (,(expand-file-name "personal.org" org-directory))
                                :inbox ,(expand-file-name "from_personal.org" org-directory)))
        org-icalendar-timezone "Europe/Istanbul")
  (map! :localleader :map 'org-mode-map :n "v" #'org-caldav-sync))
