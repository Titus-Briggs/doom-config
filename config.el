


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

         ;; Images → Preview
         (list (openwith-make-extension-regexp
                '("xbm" "pbm" "pgm" "ppm" "pnm"
                  "png" "gif" "bmp" "tif" "jpeg" "jpg"))
               "open"
               '("-a" "Preview" file))

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



;; Currently unused packages

;; ===== TRANSPARENCY =====

;; (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; (add-hook 'after-make-frame-functions
;;           (lambda (frame)
;;             (set-frame-parameter frame 'alpha '(90 . 90))))
