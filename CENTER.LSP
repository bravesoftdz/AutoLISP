(defun c:center ()
(prompt "select circle ")
(setq c (entget (car (entsel))))
(setq p (assoc 10 c) r (assoc 40 c))
(setq p0 (cdr p))
(setq a (+ (cdr r) (* 1 (getvar "dimscale"))))
(setq p1 (list (- (car p0) a) (cadr p0)))
(setq p2 (list (+ (car p0) a) (cadr p0)))
(setq p3 (list (car p0) (- (cadr p0) a)))
(setq p4 (list (car p0) (+ (cadr p0) a)))
(command "line" p1 p2 "")
(command "line" p3 p4 "")
(PRINC))
