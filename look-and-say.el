(require 'cl)

(defun lne--format (number count)
  (format "%d%s" count number))

(defun lne--add (result number count)
  (cons (lne--format number count)
        result))

(defun lne--process (numbers result current count)
  (if numbers
      (let ((next-letter (first numbers))
            (remaining (rest numbers)))
        (if (equal next-letter current)
            (lne--process remaining result current (+ count 1))
          (lne--process remaining
                        (lne--add result current count)
                        next-letter 1)))
    (lne--add result current count)))

(defun las-next-element (number-string)
  "return the next value of the look and say sequence. 

Accepts and returns strings."
  (let ((numbers-list (delete "" (split-string number-string ""))))
    (apply 'concat
           (reverse
            (lne--process (rest numbers-list) '() (first numbers-list) 1)))))

(provide 'look-and-say)
