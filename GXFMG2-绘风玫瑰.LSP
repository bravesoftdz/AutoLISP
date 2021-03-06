;风玫瑰程序: GXFMG.LSP       1989.1.
(defun C:FMG( )
 (setq pt (getpoint "风玫瑰中心点:"))
 (setq a 0)
 (setq len (getdist "O-D1之距:"))
 (setq d1 (polar pt a len))
 (setq a (+ a (/ pi 8)))
 (while (< a (* 2 pi))
  (setq len (getdist "O-D2之距:"))
  (setq d2 (polar pt a len))
  (command "line" pt d2 \r)
  (command "line" d1 d2 \r)
  (setq d1 d2)
  (setq a (+ a (/ pi 8)))
 )
)
