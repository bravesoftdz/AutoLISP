(Defun C:CLINE ()
;(IF (= (TYPE F1) 'FILE ) "YES"  (STOP))
;(IF (= (TYPE F2) 'FILE ) "YES" (STOP))
(setq d (getreal "\nLength:"))
(setq p1 (getpoint "\nPick a point:"))
(setq p2 (getpoint "\nPick a point:"))
(setq d1 (* d -1))
(setq angl (angle p1 p2))
(setq p3 (polar p1 angl d1))
(setq p4 (polar p2 angl d))
(command "layer" "s" "cen" "")
(command "line" p3 p4 "" )
(command "layer" "s"  "0" "")
)
