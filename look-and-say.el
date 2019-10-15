(require 'cl)

(defconst lne--process-function :cycle) ; can be :recursive or :cycle

(defun lne--format (number count)
  (format "%d%s" count number))

(defun lne--add (result number count)
  (cons (lne--format number count)
        result))

(defun lne--process-recursive (numbers result current count)
  "Recursion-based next step for the \"look and say sequence\"

Very limited by the (shallow) depth of the C stack"
  (if numbers
      (let ((next-letter (first numbers))
            (remaining (rest numbers)))
        (if (equal next-letter current)
            (lne--process-recursive remaining result current (+ count 1))
          (lne--process-recursive remaining
                        (lne--add result current count)
                        next-letter 1)))
    (lne--add result current count)))

(defun lne--process-dolist (numbers-list)
  (let ((numbers (rest numbers-list))
        (result '())
        (current (first numbers-list))
        (count 1))
    (dolist (next-letter numbers result)
      (if (equal next-letter current)
          (setq count (+ count 1))
        (progn
          (setq result (lne--add result current count))
          (setq count 1)
          (setq current next-letter))))
    (lne--add result current count)))

(defun lne--process (numbers-list)
  (if (eq lne--process-function :recursive)
      (lne--process-recursive (rest numbers-list) '() (first numbers-list) 1)
    (lne--process-dolist numbers-list)))

(defun las-next-element (number-string)
  "return the next value of the look and say sequence. 

Accepts and returns strings."
  (let ((numbers-list (delete "" (split-string number-string ""))))
    (apply 'concat
           (reverse
            (lne--process numbers-list)))))

(provide 'look-and-say)
