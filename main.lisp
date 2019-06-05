(defvar *year*)
(defvar *month*)
(defvar *day*)
(defvar *die-time*)

(defun readfile() 
   (with-open-file (infile "./death-date.txt" :direction :input :if-does-not-exist nil)
     (setf *year* (parse-integer (read-line infile)))
     (setf *month* (parse-integer (read-line infile)))
     (setf *day* (parse-integer (read-line infile)))
     )
   t)

(defun calc-die-time ()
  (setf *die-time* (encode-universal-time 0 0 0 *day* *month* *year*))
  (- *die-time* (get-universal-time)))

(defun years-to-live ()
  (nth-value 0 (floor (- *die-time* (get-universal-time)) 31536000)))

(defun years-to-live-remainder ()
  (nth-value 1 (floor (- *die-time* (get-universal-time)) 31536000)))

(defun days-to-live ()
  (nth-value 0 (floor (years-to-live-remainder) 86400)))

(defun days-to-live-remainder ()
  (nth-value 1 (floor (years-to-live-remainder) 86400)))

(defun hours-to-live ()
  (nth-value 0 (floor (days-to-live-remainder) 3600)))

(defun hours-to-live-remainder ()
  (nth-value 1 (floor (days-to-live-remainder) 3600)))

(defun minutes-to-live ()
  (nth-value 0 (floor (hours-to-live-remainder) 60)))

(defun minutes-to-live-remainder ()
  (nth-value 1 (floor (hours-to-live-remainder) 60)))

(defun seconds-to-live ()
  (minutes-to-live-remainder))

(defun print-ttl()
  (format t "~%~D y ~D d ~D h ~D m ~D s"
	  (years-to-live) (days-to-live) (hours-to-live) (minutes-to-live) (seconds-to-live)))
