(require 'buttercup)
(setq load-path (cons "." load-path))
(require 'look-and-say)

(describe "look-and-say.el"
  (describe "las-next-element")
  (it "1 → 11"
    (expect (las-next-element "1")
            :to-equal "11"))
  (it "1211 → 111221"
    (expect (las-next-element "1211")
            :to-equal  "111221"))
  (it "111221 → 312211"
    (expect (las-next-element "111221")
            :to-equal  "312211")))

(defun quick-test (&optional seed limit)
  (let ((current (or (format "%s" seed) "1"))
        (stop-regexp (regexp-quote (or (format "%s" limit) "3"))))
    (while (not (string-match-p stop-regexp current))
      (setq current (las-next-element current))
      (insert (format "%d: %s\n" (length current) current)))))
