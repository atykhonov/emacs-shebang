(ert-deftest test-shebang--which-env ()
  (should (string-equal
           (shebang--which "env")
           "/usr/bin/env")))

(ert-deftest test-shebang--which-python ()
  (should (string-equal
           (shebang--which "bash")
           "/bin/bash")))

(ert-deftest test-shebang--which-blablabla ()
  (should-error (shebang--which "blablabla")))

;; tests for shebang for command

(ert-deftest test-shebang-for-command--insert ()
  (should (string-equal
           (with-temp-buffer
             (shebang-for-command--insert "bash")
             (buffer-string))
           "#!/bin/bash")))

(ert-deftest test-shebang-for-command-insert-at-point ()
  (should (string-equal
           (with-temp-buffer
             (insert "some text\n")
             (shebang-for-command-insert-at-point "bash")
             (buffer-string))
           "some text\n#!/bin/bash")))

(ert-deftest test-shebang-for-command-insert ()
  (should (string-equal
           (with-temp-buffer
             (insert "some text\n")
             (shebang-for-command-insert "bash")
             (buffer-string))
           "#!/bin/bashsome text\n")))

;; tests for shebang for env with command

(ert-deftest test-shebang-for-env-with-command--insert ()
  (should (string-equal
           (with-temp-buffer
             (shebang-for-env-with-command--insert "bash")
             (buffer-string))
           "#!/usr/bin/env bash")))

(ert-deftest test-shebang-for-env-with-command-insert-at-point ()
  (should (string-equal
           (with-temp-buffer
             (insert "random text\n")
             (shebang-for-env-with-command-insert-at-point "bash")
             (buffer-string))
           "random text\n#!/usr/bin/env bash")))

(ert-deftest test-shebang-for-env-with-command-insert ()
  (should (string-equal
           (with-temp-buffer
             (insert "random text\n")
             (shebang-for-env-with-command-insert "bash")
             (buffer-string))
           "#!/usr/bin/env bashrandom text\n")))

;; common tests

(ert-deftest test-shebang--for-command ()
  (should (string-equal
           (shebang--for-command "bash")
           "#!/bin/bash")))

(ert-deftest test-shebang--for-command-with-parameters ()
  (should (string-equal
           (shebang--for-command "env" "bash")
           "#!/usr/bin/env bash")))

(ert-deftest test-shebang--format ()
  (should (string-equal
           "#!anystring"
           (shebang--format "anystring"))))

(ert-deftest test-shebang--format-with-parameters ()
  (should (string-equal
           "#!anystring args"
           (shebang--format "anystring" "args"))))

(ert-deftest test-shebang--beginning-of-buffer ()
  (should (equal
           1
           (with-temp-buffer
             (insert "any text")
             (insert "random text")
             (insert "test test")
             (goto-char 10)
             (shebang--goto-beginning-of-buffer)
             (point)))))
