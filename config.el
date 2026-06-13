
(setq doom-theme 'doom-one)
(setq org-directory "~/org-roam/")

;; ===== ORG ROAM =====

(use-package org-roam
  :ensure t
  :after org
  :demand t
  :init
  (setq org-roam-v2-ack t)
  (setq org-roam-directory (file-truename "~/org-roam"))
  (setq org-roam-extra-directories '("~/org-roam/org"))
  (setq org-roam-completion-everywhere t)
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (org-roam-db-autosync-mode))

(use-package org-roam-ui
  :ensure t
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t))


;; ===== HEADERS ====

(use-package! org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq
   org-superstar-remove-leading-stars t
   org-superstar-headline-bullets-list
   '("◉" "○" "●" "◈" "◆")))


;; ===== OPEN WITH MODE =====

(when (require 'openwith nil 'noerror)
  (setq openwith-associations
        (list
         ;; Video & audio → VLC
         (list (openwith-make-extension-regexp
                '("mpg" "mpeg" "mp3" "mp4"
                  "avi" "wmv" "wav" "mov" "flv"
                  "ogm" "ogg" "mkv"))
               "open"
               '("-a" "VLC" file))

;; Not included as interferes with org-download

;;         ;; Images → Preview
;;         (list (openwith-make-extension-regexp
;;                '("xbm" "pbm" "pgm" "ppm" "pnm"
;;                  "png" "gif" "bmp" "tif" "jpeg" "jpg"))
;;               "open"
;;               '("-a" "Preview" file))

         ;; Office docs → ONLYOFFICE
         (list (openwith-make-extension-regexp
                '("doc" "docx" "xls" "xlsx" "ppt" "pptx"
                  "odt" "ods" "odp"))
               "open"
               '("-a" "ONLYOFFICE" file))

         ;; PDFs → Preview
         (list (openwith-make-extension-regexp
                '("pdf" "ps" "ps.gz" "dvi"))
               "open"
               '("-a" "Preview" file))
         ))
  (openwith-mode 1))



;; ===== AGENDA SETUP =====

(defun titus/agenda-visual-cleanup ()
  "Apply a clean, modern visual style to the agenda buffer."
  (setq-local line-spacing 4)
  (setq-local mode-line-format nil)
  (setq-local header-line-format " ")
  (set-window-margins (selected-window) 4 4))

(add-hook 'org-agenda-finalize-hook #'titus/agenda-visual-cleanup)

(add-hook 'org-agenda-finalize-hook
          (lambda ()
            (mixed-pitch-mode 1)
            (set-face-attribute 'org-agenda-structure nil :height 1.2)))

(setq org-agenda-block-separator nil)

(setq org-agenda-prefix-format
      '((agenda . "  %?-12t %s")
        (todo   . "  ")
        (search . "  ")))

(setq org-agenda-current-time-string "ᐊ┈┈┈┈┈┈┈ Now")

(setq org-agenda-time-grid
      '((today require-timed)
        ()
        "    "
        "┈┈┈┈┈┈┈┈┈┈┈"))

(add-hook 'org-agenda-mode-hook (lambda () (doom-modeline-mode -1)))

(add-to-list 'default-frame-alist '(internal-border-width . 12))
(set-frame-parameter nil 'alpha-background 94)

(with-eval-after-load 'org-agenda
  (set-face-attribute 'org-agenda-date nil
                      :weight 'bold
                      :foreground nil)
  (set-face-attribute 'org-agenda-date-today nil
                      :weight 'bold
                      :underline t
                      :foreground nil)
  (set-face-attribute 'org-agenda-current-time nil
                      :foreground "yellow"
                      :weight 'bold))

(with-eval-after-load 'org
  (add-to-list 'org-todo-keyword-faces
               '("PROJ" . (:foreground "orange" :weight bold))))

;; -----

(setq org-agenda-custom-commands
      '(("a" "Titus Agenda"
         (
          ;; 🕒 Schedule
          (agenda ""
                  ((org-agenda-span 5)
                   (org-agenda-start-day "+0d")
                   (org-agenda-overriding-header "🕒 Schedule")
                   (org-agenda-remove-tags t)
                   (org-agenda-skip-scheduled-if-done t)
                   (org-agenda-skip-deadline-if-done t)))

          ;; ⚡ Do Today
          (todo "TODO"
                ((org-agenda-overriding-header "\n⚡ Do Today")
                 (org-agenda-remove-tags t)
                 (org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'timestamp 'scheduled))))

          ;; 📚 Projects
          (todo "PROJ"
                ((org-agenda-overriding-header "\n📚 Projects")
                 (org-agenda-remove-tags t)
                 (org-tags-match-list-sublevels nil)))))))








;; Currently unused packages

;; ===== TRANSPARENCY =====

;; (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; (add-hook 'after-make-frame-functions
;;           (lambda (frame)
;;             (set-frame-parameter frame 'alpha '(90 . 90))))
