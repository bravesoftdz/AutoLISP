(defun c:tt (/ p1 p2 lst)  
  (princ "\nWRITEN BY WKAI , XDCAD.NET , 20040611")
  (setvar "ORTHOMODE" 0)
  (setvar "cmdecho" 1)
  (setq p1 (getpoint "\n指定第一点:"))
  (setq p2 (getpoint p1 "\n指定下一点:"))
  (setq p1 (trans p1 1 0))
  (setq p2 (trans p2 1 0))
  (entmake (list (cons 0 "LINE") (cons 10 P1) (cons 11 P2)))
  (command "_.ucs" "ob" (entlast))
  (entdel (entlast))
  (setvar "ORTHOMODE" 1)
  (command "_.pline" (trans p1 0 1) (trans p2 0 1))
  (while (= (getvar "cmdnames") "PLINE")
    (command pause)
    )
  (command)
  (command "_.ucs" "p")
)