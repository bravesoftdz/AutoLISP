;坐标标注（土建）
(defun C:ZB01()
(command "osnap" "int")
(SETQ P0 (GETPOINT "\n基准点:")) (command "osnap" "off")
(setq x0 (car p0) y0 (cadr p0))
(setq y (getreal "\n基准点座标值 A=<0>"))
(setq X (getreal "\n基准点座标值 B=<0>"))
(if (= x nil)(setq x 0.00))
(if (= y nil)(setq y 0.00))
(if (> bl 0) (zzb))
;(command "osnap" "int")
)
;
(defun zzb()
(command "osnap" "int,CEN")
(SETQ P1 (GETPOINT "标注点:")) (COMMAND "OSNAP" "OFF")
(while (/= p1 nil)
    (SETQ P2 (GETPOINT "第二点:"))
    (setq x1 (car p1) y1 (cadr p1) x2 (car p2) y2 (cadr p2))
    (setq a1 (- y1 y0) b1 (- x1 x0))
    (setq a1 (+ (* bl a1 0.001) y) b1 (+ (* bl b1 0.001) x))
    (setq a2 (rtos a1 2 3) b2 (rtos b1 2 3))
    (setq a3 (strcat "座标值A=<" A2 ">:"))
    (setq B3 (strcat "座标值B=<" B2 ">:"))
    (setq a (getstring a3))
    (setq b (getstring b3))
    (IF (= A "") (SETQ A A2)) (IF (= B "") (SETQ B B2))
    (SETQ A1 (STRLEN A) B1 (STRLEN B) A1 (MAX A1 B1) L (* (+ A1 3) 2.0))
    (IF (> X2 X1) (SETQ X3 (+ X2 L)) (SETQ X3 (- X2 L)))
    (SETQ P3 (LIST X3 Y2))
    (IF (> X2 X1) 
        (SETQ P4 (LIST (+ X2 2) (+ Y2 0.8)) P5 (LIST (+ X2 2) (- Y2 3.3)))
        (SETQ P4 (LIST (+ X3 2) (+ Y2 0.8)) P5 (LIST (+ X3 2) (- Y2 3.3)))
        )
    (SETQ P6 (POLAR P4 0.0 4.0) P7 (POLAR P5 0.0 4.0))
    (COMMAND "LINE" P1 P2 P3 "")
    (COMMAND "TEXT" "S" "ST" P4 2.5 0 "A=")
    (COMMAND "TEXT" P5 2.5 0 "B=")
    (COMMAND "TEXT" P6 2.5 0 A)
    (COMMAND "TEXT" P7 2.5 0 B)
    (COMMAND "OSNAP" "INT,CEN")
    (SETQ P1 (GETPOINT "标注点:")) (COMMAND "OSNAP" "OFF")
)
(command "osnap" "int,end,mid,nea,cen,per,tan")
)
        
