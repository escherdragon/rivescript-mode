;;; rivescript.el --- major mode for composing rivescript files

;; Copyright (C) 2018 José Alfredo Romero Latouche.

;; Author: José Alfredo Romero L. <escherdragon@gmail.com>
;; Created: 23 Mar 2018
;; Version: 1.0
;; Keywords: chatbot, rivescript, scripting, syntax

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation, either version 3 of the License, or (at your option) any later
;; version.
;;
;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE. See the GNU General Public License for more de-
;; tails.

;; You should have received a copy of the GNU General Public License along with
;; this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is a major mode to add syntax highlighting to rivescript code.

;; Rivescript is a very simple, line-oriented mark-up language for scripting
;; chatbots. For more details, visit: https://www.rivescript.com

;;; Installation:

;; Put this file somewhere in your load-path, and then add the following line
;; to your .emacs file:

;; (require 'rivescript)

;; Then you can manually enable the mode with M-x rivescript-mode, or you can
;; associate it with a file extension:

;; (add-to-list 'auto-mode-alist '("\\.rive\\'" . rivescript-mode))

;; Enjoy ;-)

;;; Code:

(setq rivescript-highlights '(("." . font-lock-builtin-face)))

(defface rivescript-arrow-face
  '((t :inherit font-lock-comment-face :background "light yellow" :weight bold))
  "Face for the RiveScript arrow (=>)"
  :group 'rivescript-mode)

(defface rivescript-block-face
  '((t :inherit font-lock-function-name-face :weight bold))
  "Face for the names of the different topics"
  :group 'rivescript-mode)

(defface rivescript-call-face
  '((t :inherit font-lock-constant-face))
  "Face for logic execution tags: <call>, <add>, <uppercase>, etc"
  :group 'rivescript-mode)

(defface rivescript-comment-face
  '((t :inherit font-lock-comment-face))
  "Face for in-line comments"
  :group 'rivescript-mode)

(defface rivescript-control-flow-face
  '((t :inherit font-lock-warning-face))
  "Face for tags that affect the flow of the script: {topic}, {weight}, etc"
  :group 'rivescript-mode)

(defface rivescript-definition-face
  '((t :inherit font-lock-warning-face))
  "Face for definitions (!)"
  :group 'rivescript-mode)

(defface rivescript-previous-face
  '((t :foreground "dark orange"))
  "Face for previous responses (%)"
  :group 'rivescript-mode)

(defface rivescript-reply-face
  '((t :inherit font-lock-type-face))
  "Face for default replies (-), conditionals (*) and continuations (^)"
  :group 'rivescript-mode)

(defface rivescript-space-face
  '((t :inherit font-lock-type-face :weight bold))
  "Face for the white-space tags: \n, \s"
  :group 'rivescript-mode)

(defface rivescript-trigger-face
  '((t :inherit font-lock-keyword-face))
  "Face for triggers (+) and redirections (@)"
  :group 'rivescript-mode)

(defface rivescript-variable-face
  '((t :inherit font-lock-variable-name-face))
  "Face for variable manipulation tags: <get>, <set>, <bot>, <star>, etc"
  :group 'rivescript-mode)

(define-derived-mode rivescript-mode fundamental-mode "rivescript"
  "Major mode for composing rivescript files"
  (setq font-lock-defaults '(rivescript-highlights)))

(font-lock-add-keywords
 'rivescript-mode
 '(
   ("^\s*[+@].*" 0 'rivescript-trigger-face t)
   ("^\s*%.*" 0 'rivescript-previous-face t)
   ("^\s*[-^*].*" 0 'rivescript-reply-face t)
   ("^>\s\\(?:begin\\|topic\s[a-zA-Z0-9_]+\\|object\s[a-zA-Z0-9_]+\s[a-zA-Z0-9_]+\\)$" 0 'rivescript-block-face t)
   ("^<\s\\(?:begin\\|topic$\\|object\\)$" 0 'rivescript-block-face t)

   ("<call>.*?</call>" 0 'rivescript-call-face t)
   ("\\(?:{@[^}]*}\\|<@>\\|{@}\\)" 0 'rivescript-trigger-face t)
   ("<\\(?:add\\|sub\\|mult\\|div\\).*?>" 0 'rivescript-call-face t)
   ("<\\(?:[gs]et\\|bot\\).*?>" 0 'rivescript-variable-face t)
   ("<\\(?:\\(?:bot\\)?star\\|input\\|reply\\|env\\)[0-9]*?>" 0 'rivescript-variable-face t)
   ("<id>\\|<person>\\|<formal>\\|<sentence>\\|<uppercase>\\|<lowercase>" 0 'rivescript-call-face t)

   ("//.*" 0 'rivescript-comment-face t)
   ("{\\(?:topic\\|weight\\|random\\)=.*?}" 0 'rivescript-control-flow-face t)
   ("{/?random}\\|{ok}" 0 'rivescript-control-flow-face t)
   ("\\\\[sn]" 0 'rivescript-space-face t)
   ("\\_<=>\\_>" 0 'rivescript-arrow-face t)
   ("^\s*!.*" 0 'rivescript-definition-face t)
   ))

(provide 'rivescript)
