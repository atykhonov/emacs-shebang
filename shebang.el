;;; shebang.el --- Package which helps insert shebang for a command

;; Copyright (C) 2014 Andrey Tykhonov <atykhonov@gmail.com>

;; Author: Andrey Tykhonov <atykhonov@gmail.com>
;; URL: https://github.com/atykhonov/emacs-shebang
;; Version: 0.1.0
;; Keywords: convenience

;; This file is NOT part of GNU Emacs.

;; This is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Installation:

;; Assuming that the file `shebang.el' is somewhere on the load path,
;; add the following lines to your `.emacs' file:
;;
;; (require 'shebang)
;; (global-set-key "\C-c b i" 'shebang-insert)
;;
;;  Change the key bindings to your liking.
;;

;;; Commentary:

;;
;; `shebang-insert' queries for a command and inserts shebang line for
;; it.
;;
;; For example an execution of such command:
;;
;; M-x shebang-insert RET python RET
;;
;; will insert at point shebang line like:
;;
;; #!/usr/bin/python
;;
;; With a `C-u' frefix `shebang-insert' queries for a command and
;; insert shebang line for `env' and a command.
;;
;; As example an execution of such command:
;;
;; C-u M-x shebang-insert RET perl RET
;;
;; will insert at point shebang line like:
;; 
;; #!/usr/bin/env perl
;;

;;; Code:

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
  White space here is any of: space, tab, emacs newline (line
  feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n\r]*" ""
                            (replace-regexp-in-string "[ \t\n\r]*\\'"
                                                      ""
                                                      string)))

(defun shebang--which (command)
  "Return the full path of COMMAND."
  (trim-string
   (shell-command-to-string (format "which %s" command))))

(defun shebang--for-command (command)
  "Return shebang line for COMMAND."
  (let ((command-path (shebang--which command)))
    (shebang--format command-path)))

(defun shebang-insert (override-p)
  "Insert at point shebang line for command about which you'll be queried.

With a `C-u' prefix argument, insert at point shebang line for
`env' with COMMAND."
  (interactive "P")
  (if override-p
      (call-interactively 'shebang-for-env-with-command-insert)
    (call-interactively 'shebang-for-command-insert)))

(defun shebang--for-env-with-command (command)
  "Return shebang line for env with COMMAND."
  (let ((env-path (shebang--which "env")))
    (shebang--format (format "%s %s" env-path command))))

(defun shebang-for-command-insert (command)
  "Insert at point shebang line for COMMAND."
  (interactive "sCommand: ")
  (insert (shebang--for-command command)))

(defun shebang-for-env-with-command-insert (command)
  "Insert at point shebang line for env with COMMAND."
  (interactive "sCommand: ")
  (insert (shebang--for-env-with-command command)))

(defun shebang-env-insert (command)
  "Insert shebang line for env with COMMAND."
  (interactive "sCommand: ")
  (insert (shebang--for-env-with-command command)))

(defun shebang--format (string)
  "Format shebang line with STRING."
  (format "#!%s" string))


(provide 'shebang)

;;; shebang.el ends here
