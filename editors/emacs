(require 'package)
; ("melpa" . "https://melpa.org/packages/")
(setq package-archives '(("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
                         ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-archives)
  (package-install 'use-package))

(use-package evil
  :ensure t
  :config
  (evil-mode 1))
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :mode ("\\.markdown\\'" . markdown-mode))

(custom-set-variables
 '(package-selected-packages
   '(evil-org evil-surround markdown-mode use-package-chords
	      use-package-x)))
(custom-set-faces)

(setq-default highlight-tabs t)
(load-theme 'tango-dark t)
(global-display-line-numbers-mode t)


;; Optional: Define a keybinding for the function
;; This example uses "C-c n" as an example. Replace with your preferred keybinding.
;; If you have a leader key setup similar to Vim, you might need to configure that first.
;; (global-set-key (kbd "C-c n") 'toggle-line-number-mode)
(defun toggle-line-number-mode ()
  "Toggle between absolute line numbers, relative line numbers, and no line numbers.
This mimics the behavior of the provided Vimscript function."
  (interactive)
  (cond
   ((and (or (eq display-line-numbers t) (eq display-line-numbers 'absolute))
         (not (eq display-line-numbers 'relative)))
    (display-line-numbers-mode -1)
    (setq-local display-line-numbers 'relative)
    (message "Relative line numbers enabled"))

   ((and (not (or (eq display-line-numbers t) (eq display-line-numbers 'absolute)))
         (eq display-line-numbers 'relative))
    (setq-local display-line-numbers nil)
    (display-line-numbers-mode 1)
    (message "Absolute line numbers enabled"))

   ((and (not (or (eq display-line-numbers t) (eq display-line-numbers 'absolute)))
         (not (eq display-line-numbers 'relative)))
    (display-line-numbers-mode 1)
    (message "Absolute line numbers enabled"))

   (t (message "ToggleLineNumberMode: Unexpected state!")
    ;; Optionally, just turn absolute numbers back on
    ;; (display-line-numbers-mode 1)
    )))

