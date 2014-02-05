(require 'f)
(require 's)
(require 'dash)
(require 'el-mock)

(defvar shebang-test/test-path
  (f-dirname load-file-name))

(defvar shebang-test/root-path
  (f-parent shebang-test/test-path))

(setq debug-on-entry t)
(setq debug-on-error t)

(add-to-list 'load-path shebang-test/root-path)

(require 'shebang
         (f-expand "shebang"
                   shebang-test/root-path))
