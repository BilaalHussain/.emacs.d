;;; init-search.el --- -*- lexical-binding: t -*-
;;
;; Filename: init-search.el
;; Description: Initialize Packages for Searching
;; Author: Mingde (Matthew) Zeng
;; Copyright (C) 2019 Mingde (Matthew) Zeng
;; Created: Thu Mar 14 11:01:43 2019 (-0400)
;; Version: 2.0.0
;; Last-Updated: Sun Nov 24 14:50:57 2019 (-0500)
;;           By: Mingde (Matthew) Zeng
;; URL: https://github.com/MatthewZMD/.emacs.d
;; Keywords: M-EMACS .emacs.d color-rg rg
;; Compatibility: emacs-version >= 26.1
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; This initializes ivy swiper counsel color-rg snails howdoyou
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(eval-when-compile
  (require 'init-global-config)
  (require 'init-const))

;; IvyPac
(use-package ivy
  :bind ("M-s M-s" . swiper-isearch)
  :diminish
  :init
  (use-package amx :defer t)
  (use-package counsel
    :diminish
    :bind ("M-s M-k" . counsel-git-grep)
    :config (counsel-mode 1))
  (use-package swiper :defer t)
  (ivy-mode 1)
  :bind
  (:map ivy-minibuffer-map
        ("C-r" . ivy-previous-line-or-history))
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-height 10)
  (ivy-on-del-error-function nil)
  (ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-create)
  (ivy-count-format "【%d/%d】")
  (ivy-wrap t)
  (ivy-use-selectable-prompt t))
;; -IvyPac

;; IvyPosframePac
(unless (version< emacs-version "26")
  (use-package ivy-posframe
    :if *sys/gui*
    :diminish
    :custom-face
    (ivy-posframe ((t (:background "#303640"))))
    :custom
    (ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
    :config
    (ivy-posframe-mode 1)))
;; -IvyPosframePac

;; ColorRGPac
(use-package color-rg
  :load-path "~/.emacs.d/site-elisp/color-rg"
  :if *rg*
  :bind ("C-M-s" . color-rg-search-input))
;; -ColorRGPac

;; SnailsPac
(use-package snails
  :load-path "~/.emacs.d/site-elisp/snails/"
  :if *sys/gui*
  :custom-face
  (snails-content-buffer-face ((t (:background "#111" :height 110))))
  (snails-input-buffer-face ((t (:background "#222" :foreground "gold" :height 110))))
  (snails-header-line-face ((t (:inherit font-lock-function-name-face :underline t :height 1.1))))
  :config
  (use-package exec-path-from-shell
    :if (featurep 'cocoa) :defer t)

  ;; Functions for specific backends
  (defun snails-current-project ()
    (interactive)
    (snails '(snails-backend-projectile snails-backend-rg snails-backend-fd)))
  (defun snails-active-recent-buffers ()
    (interactive)
    (snails '(snails-backend-buffer snails-backend-recentf)))
  (defun snails-everywhere ()
    (interactive)
    (snails '(snails-backend-everything snails-backend-mdfind)))
  :bind
  (("M-s s" . snails)
   ("M-s g" . snails-current-project)
   ("M-s b" . snails-active-recent-buffers)
   ("M-s e" . snails-everywhere)))
;; -SnailsPac

;; HowDoYouPac
(use-package howdoyou
  :defer t
  :commands (howdoyou-query))
;; -HowDoYouPac

(provide 'init-search)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ag.el ends here
