(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

; initialize package.el
(package-initialize)


(setq package-list '(auto-complete
		     yasnippet
		     auto-complete
		     auto-complete
		     hlinum
		     jedi
		     auto-complete
		     nyan-mode
		     iedit autopair
		     auto-complete-clang
		     auto-complete-clang-async
		     google-c-style
		     ac-math))

; list the repositories containing them

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

; start auto-complete with emacs
(require 'auto-complete)

;; ; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)


;; ;; ;; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

;; ;; nyan-mode
;; ;; (add-to-list 'load-path "~/.emacs.d/nyan-mode")
;; ;; (require 'nyan-mode)
 (nyan-mode 1)
;;(setq-default nyan-wavy-trail nil)
(setq nyan-wavy-trail t)
(setq nyan-bar-length 20)
(setq nyan-animate-nyancat t)
(nyan-start-animation)

;; turn on auto-indent
(add-hook 'c-mode-common-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))

;; iedit
(require 'iedit)
(define-key global-map (kbd "C-c ;") 'iedit-mode)

					; turn on Semantic
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;;enable global support for Semanticdb
					; turn on Semantic
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;;enable global support for Semanticdb
(global-semanticdb-minor-mode 1)
(global-semanticdb-minor-mode 1)


;; turn on auto-indent
(setq c-default-style "ellemtel" c-basic-offset 5)

(global-ede-mode 1)
(global-semantic-idle-scheduler-mode 1)


;; turn on autopairing of backets
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers


;; turn on highlight paren mode
(show-paren-mode 1)


;; turn on number line
(global-linum-mode t)
(setq linum-format "%d  ")


;; Show the cursor line
(require 'hlinum)
;; (hlinum-activate)


(require 'auto-complete-clang)
(require 'auto-complete-clang-async)
(global-semanticdb-minor-mode 1)
;; 					;(global-semantic-highlight-func-mode 1)
;; (global-semanticdb-minor-mode 1)


;; turn on auto-indent
(setq c-default-style "ellemtel"
      c-basic-offset 5)


					; turn on ede mode
(global-ede-mode 1)
(global-semantic-idle-scheduler-mode 1)


;; turn on copyright
;; turn on autopairing of backets
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

;; turn on highlight paren mode
(show-paren-mode 1)


;; turn on number line
(global-linum-mode t)
(setq linum-format "%d  ")


;; Show the cursor line
(require 'hlinum)
;; (hlinum-activate)


(require 'auto-complete-clang)
(require 'auto-complete-clang-async)

;; key for opening header file
(global-set-key (kbd "C-x C-o") 'ff-find-other-file)


;; Set Up color
					;Language support
(setq auto-mode-alist
      (append
       '(("\\.F$"    . fortran-mode)
	 ("\\.inc$"  . fortran-mode)
	 ("\\.C$"    . c++-mode)
	 ("\\.cc$"   . c++-mode)
	 ("\\.h$"    . c++-mode)
	 ("\\.cxx$"  . c++-mode)
	 ("\\.html$" . html-mode)
	 )
       auto-mode-alist))

					; Set up C++ variables
					;
(setq c-recognize-knr-p nil)
(add-hook 'c++-mode-hook (function (lambda () (c-set-style "Ellemtel"))))
(add-hook 'c++-mode-hook 'font-lock-mode )

;;Auto indent
(set (make-local-variable 'aai-indent-function)
     'aai-indent-defun)

;; start flymake-google-cpplint-load
;; (require 'flymake-google-cpplint)
;; (add-hook 'c++-mode-hook 'flymake-google-cpplint-load)

(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (flymake-google-cpplint-load)
  )
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)



;; start google-c-style with emacs
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)


(setq gc-cons-threshold 1000000)

(require 'ede)

(setq semantic-load-turn-useful-things-on t)

(semantic-add-system-include "/usr/include/" 'c-mode)
(semantic-add-system-include "/usr/include/" 'c++-mode)

;; C++ Mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(require 'cl)

(defun file-in-directory-list-p (file dirlist)
    "Returns true if the file specified is contained within one of
the directories in the list. The directories must also exist."
    (let ((dirs (mapcar 'expand-file-name dirlist))
	  (filedir (expand-file-name (file-name-directory file))))
      (and
       (file-directory-p filedir)
       (member-if (lambda (x) ; Check directory prefix matches
		    (string-match (substring x 0 (min(length filedir) (length x))) filedir))
		  dirs))))

(defun buffer-standard-include-p ()
    "Returns true if the current buffer is contained within one of
the directories in the INCLUDE environment variable."
    (and (getenv "INCLUDE")
	 (file-in-directory-list-p buffer-file-name (split-string (getenv "INCLUDE") path-separator))))

(add-to-list 'magic-fallback-mode-alist '(buffer-standard-include-p . c++-mode))

					; style I want to use in c++ mode
(c-add-style "my-style"
	     '("stroustrup"
	       (indent-tabs-mode . nil)        ; use spaces rather than tabs
	       (c-basic-offset . 4)            ; indent by four spaces
	       (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
				   (brace-list-open . 0)
				   (statement-case-open . +)))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style")        ; use my-style defined above
  (auto-fill-mode)
  (c-toggle-auto-hungry-state 1))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; (define-key c++-mode-map "\C-ct" 'some-function-i-want-to-call)



					; roslaunch highlighting
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))


					;(require 'yaml-mode)
					;    (add-to-list 'auto-mode-alist '("\\yaml$" . yaml-mode))

					;(add-hook 'yaml-mode-hook
					;      '(lambda ()
					;        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
					; Add cmake listfile names to the mode list.
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))

(autoload 'cmake-mode "/usr/share/emacs/site-lisp/cmake-mode.el" t)



;; color the entire line
(global-hl-line-mode 1)
;; To customize the background color
(set-face-background 'hl-line "magenta")
;; -- color of line
(set-face-background 'hl-line "#cd1076")


;; python auto-complete
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "0c9f63c9d90d0d135935392873cd016cc1767638de92841a5b277481f1ec1f4a" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f" "6bc387a588201caf31151205e4e468f382ecc0b888bac98b2b525006f7cb3307" default)))
 '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
 '(package-selected-packages
   (quote
    (makefile-executor dockerfile-mode docker docker-compose-mode zenburn-theme monokai-theme gruvbox-theme cyberpunk-theme html-check-frag web-mode python-docstring flycheck-pycheckers jedi-core color-theme-x yaml-tomato flymake-elixir color-theme-solarized cuda-mode pylint elpy ac-math ecb solarized-theme latex-preview-pane yatemplate yaml-mode jedi iedit hlinum google-c-style git flymake-google-cpplint flymake-cursor flymake-cppcheck el-autoyas autopair auto-yasnippet auto-complete-nxml auto-complete-exuberant-ctags auto-complete-clang-async auto-complete-clang auto-complete-chunk auto-complete-c-headers auto-auto-indent ac-c-headers))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; Indentation for python

;; Ignoring electric indentation
(defun electric-indent-ignore-python (char)
  "Ignore electric indentation for python-mode"
  (if (equal major-mode 'python-mode)
      'no-indent
    nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-python)

;; Enter key executes newline-and-indent
(defun set-newline-and-indent ()
  "Map the return key with `newline-and-indent'"
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'python-mode-hook 'set-newline-and-indent)


;; Turn on auto-insert
(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.c\\'" . "C skeleton")
     '(
       "Short description: "
       "/**\n * "
       (file-name-nondirectory (buffer-file-name))
       " -- " str \n
       " *" \n
       " * Written on " (format-time-string "%A, %e %B %Y.") \n
       " */" > \n \n
       "#include <stdio.h>" \n
       "#include \""
       (file-name-sans-extension
	(file-name-nondirectory (buffer-file-name)))
       ".h\"" \n \n
       "int main(int argc, const char* argv[]) {" \n
       "return 0;" >
       > _ \n
       "}" > \n)))



;; turn on lisp autocomplete
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

;; turn on offscreen bracket highlight
(defadvice show-paren-function
    (after show-matching-paren-offscreen activate)
  (interactive)
  (let* ((cb (char-before (point)))
	 (matching-text (and cb
			     (char-equal (char-syntax cb) ?\) )
			     (blink-matching-open))))
    (when matching-text (message matching-text))))


(if window-system (require 'font-latex))
(setq font-lock-maximum-decoration t)


;; Change color of C/C++ comment
(set-face-foreground 'font-lock-string-face "green")
(set-face-foreground 'font-lock-comment-face "red")

;; latex ac-maths
(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)
(defun ac-latex-mode-setup ()
  (setq ac-sources
	(append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
		ac-sources)))
(add-hook 'TeX-mode-hook 'ac-latex-mode-setup)


;; ace popup
;; (ace-popup-menu-mode 1)

					;for cuda files
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))

;; (defun remove-dos-eol ()
;;   "Do not show ^M in files containing mixed UNIX and DOS line endings."
;;   (interactive)
;;   (setq buffer-display-table (make-display-table))
;;   (aset buffer-display-table ?\^M []))

(setq auto-mode-alist
      (cons
       '("\\.m$" . octave-mode)
       auto-mode-alist))
(put 'upcase-region 'disabled nil)


;; latex setup
(require 'flymake)
;; (defun flymake-get-tex-args (file-name)
;;   (list "pdflatex"
;; 	(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))
;; (add-hook 'LaTeX-mode-hook 'flymake-mode)

(require 'ispell)
(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o")

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))

(add-hook 'yaml-mode-hook
        (lambda ()
	  (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; ;; emacs pylint
;; ;; Configure flymake for Python
;; (when (load "flymake" t)
;;   (defun flymake-pylint-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "epylint" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pylint-init)))

;; ;; Set as a minor mode for Python
;; (add-hook 'python-mode-hook '(lambda () (flymake-mode)))

;; ;; Configure to wait a bit longer after edits before starting
;; (setq-default flymake-no-changes-timeout '3)

;; ;; Keymaps to navigate to the errors
;; (add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cn" 'flymake-goto-next-error)))
;; (add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cp" 'flymake-goto-prev-error)))

;; ;; appear in the minibuffer
;; (defun show-fly-err-at-point ()
;;   "If the cursor is sitting on a flymake error, display the message in the minibuffer"
;;   (require 'cl)
;;   (interactive)
;;   (let ((line-no (line-number-at-pos)))
;;     (dolist (elem flymake-err-info)
;;       (if (eq (car elem) line-no)
;;       (let ((err (car (second elem))))
;;         (message "%s" (flymake-ler-text err)))))))

;; (add-hook 'post-command-hook 'show-fly-err-at-point)

;; (defadvice flymake-goto-next-error (after display-message activate compile)
;;   "Display the error in the mini-buffer rather than having to mouse over it"
;;   (show-fly-err-at-point))

;; (defadvice flymake-goto-prev-error (after display-message activate compile)
;;   "Display the error in the mini-buffer rather than having to mouse over it"
;;   (show-fly-err-at-point))

;; (add-hook 'after-init-hook #'global-flycheck-mode)

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
