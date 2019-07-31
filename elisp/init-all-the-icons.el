;;; init-all-the-icons.el --- -*- lexical-binding: t -*-
;;
;; Copyright (C) 2019 Mingde Zeng
;;
;; Filename: init-all-the-icons.el
;; Description: Initialize All-The-Icons
;; Author: Mingde (Matthew) Zeng
;; Created: Thu Mar 14 17:06:08 2019 (-0400)
;; Version: 2.0.0
;; Last-Updated: Wed Jul 31 11:03:41 2019 (-0400)
;;           By: Mingde (Matthew) Zeng
;; URL: https://github.com/MatthewZMD/.emacs.d
;; Keywords: M-EMACS .emacs.d all-the-icons
;; Compatibility: emacs-version >= 26.1
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; This initializes all-the-icons, all-the-icons-dired, all-the-icons-ivy
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
  (require 'init-const))

;; ATIPac
(use-package all-the-icons :if *sys/gui*)
;; -ATIPac

;; ATIDiredPac
(use-package all-the-icons-dired
  :after all-the-icons
  :if *sys/gui*
  :diminish
  :custom-face
  (all-the-icons-dired-dir-face ((t `(:foreground ,(face-background 'default)))))
  :config
  (add-hook 'dired-mode-hook #'all-the-icons-dired-mode)
  ;; Workaround for all-the-icons bug until PR merged https://github.com/domtronn/all-the-icons.el/pull/150
  (when (require 'all-the-icons nil 'noerror)
    (setq all-the-icons-mode-icon-alist
          (delete '(erc-mode all-the-icons-faicon "commenting-o" :height 1.0 :v-adjust 0.0 :face all-the-icons-white) all-the-icons-mode-icon-alist))
    (add-to-list 'all-the-icons-mode-icon-alist '(erc-mode all-the-icons-faicon "commenting-o" :height 1.0 :v-adjust 0.0))))
;; -ATIDiredPac

(provide 'init-all-the-icons)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-all-the-icons.el ends here
