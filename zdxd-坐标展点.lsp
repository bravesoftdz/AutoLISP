;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; By Chen Yuan
; 
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
(defun zdt_gy()
(setq index_value (load_dialog "zdt.dcl"))
(if (not (new_dialog "zdt_gy" index_value)) (exit))
(start_dialog)
(unload_dialog index_value)
(princ)
) 

(defun k_zd()
(command "layer" "s" "控制点" "")
(command "pline" (list d_x1 d_y) "w" "0" "0" (list d_x2 d_y) "")
(command "pline" (list d_x d_y1) "w" "0" "0" (list d_x d_y2) "")
(command "pline" (list d_x5 d_y) "w" "0" "0" (list (+ d_x5 10) d_y) "")
(command "pline" (list d_x6 d_y) "w" "0" "0" (list (+ d_x6 11.25) d_y) "")
(command "pline" (list d_x3 d_y3) (list d_x3 d_y4) (list d_x4 d_y4) (list d_x4 d_y3) "c")
(command "text" (list d_x5 d_y5) "1.5" "90" d_m)
(command "text" (list d_x5 d_y6) "1.5" "90" (strcat "H=" (rtos d_h)))
(command "text" (list d_x6 d_y5) "1.5" "90" (strcat "X=" (rtos d_y)))
(command "text" (list d_x6 d_y6) "1.5" "90" (strcat "Y=" (rtos d_x)))
)

(defun d_zd()
(command "layer" "s" "地形点" "")
(command "circle" (list d_x d_y) ".1")
(command "text" (list (+ d_x 0.5) (1- d_y)) "1" "90" d_m)
(command "layer" "s" "高程" "")
(command "text" (list (+ d_x 0.5) d_y) "1" "90" (rtos d_h))
)

(defun z_zd()
(command "layer" "s" "中线点" "")
(command "circle" (list d_x d_y) "0.5")
(command "pline" (list d_x1 d_y) "w" "0" "0" (list d_x2 d_y) "")
(command "pline" (list d_x d_y1) "w" "0" "0" (list d_x d_y2) "")
(command "pline" (list d_x6 d_y) "w" "0" "0" (list (+ d_x6 10.0) d_y) "")
(command "text" (list d_x5 (- d_y 0.75)) "1.5" "90" d_m)
(command "text" (list d_x6 d_y5) "1.5" "90" (strcat "X=" (rtos d_y)))
(command "text" (list d_x6 d_y6) "1.5" "90" (strcat "Y=" (rtos d_x)))
)

(defun c:zdxd()
(zdt_gy)
(setq sblip (getvar "blipmode"))
(setq scmde (getvar "cmdecho"))
(setvar "cmdecho" 0)
(setvar "blipmode" 0)
(command "units" "2" "3" "2" "5" "270" "y")
(command "layer" "n" "sz" "c" "1" "sz" "")
(command "layer" "n" "sj" "c" "5" "sj" "")
(command "layer" "n" "控制点" "c" "4" "控制点" "")
(command "layer" "n" "地形点" "c" "3" "地形点" "")
(command "layer" "n" "中线点" "c" "3" "中线点" "")
(command "layer" "n" "高程" "c" "3" "高程" "")
(command "layer" "n" "图框" "c" "7" "图框" "")
(setq nam (getfiled "打开数据文件" "/acad/" "dat" 8))
(princ "\n正在绘图, 请稍侯 ......")
(setq d_f (open nam "r"))
(setq d_l (read-line d_f))
(setq d_l (strcat "(" d_l ")"))
(setq d_l (read d_l))
(setq d_ll d_l)
(setq x_max (nth 3 d_l)
y_max (nth 2 d_l))
(setq x_min x_max y_min y_max)
(while (not (null d_ll))
(setq d_lx (car d_l)
d_m (nth 1 d_l)
d_x (nth 3 d_l)
d_y (nth 2 d_l)
d_h (last d_l))
(setq d_x1 (- d_x 0.25)
d_x2 (+ d_x 0.25)
d_x3 (- d_x 0.75)
d_x4 (+ d_x 0.75)
d_x5 (+ d_x 1.25) 
d_x6 (+ d_x 12.5))
(setq d_y1 (- d_y 0.25)
d_y2 (+ d_y 0.25)
d_y3 (- d_y 0.75)
d_y4 (+ d_y 0.75)
d_y5 (+ d_y 0.5) 
d_y6 (- d_y 2.0))
(setq x_max (max x_max d_x))
(setq y_max (max y_max d_y))
(setq x_min (min x_min d_x))
(setq y_min (min y_min d_y))
(if (or (= d_lx "Z") (= d_lx "z"))
(z_zd)
)
(if (or (= d_lx "K") (= d_lx "k"))
(k_zd)
)
(if (or (= d_lx "D") (= d_lx "d"))
(d_zd)
)
(setq d_l (read-line d_f))
(setq d_l (strcat "(" d_l ")"))
(setq d_l (read d_l))
(setq d_ll d_l)
)
(setq x_db (* 250.0 (1+ (fix (/ x_max 250.0)))))
(setq y_db (* 250.0 (1+ (fix (/ y_max 250.0)))))
(setq x_xn (* 250.0 (fix (/ x_min 250.0))))
(setq y_xn (* 250.0 (fix (/ y_min 250.0))))
(command "layer" "s" "图框" "")
(command "pline" (list x_db y_db) "w" "0.6" "0.6" (list x_xn y_db) (list x_xn y_xn) (list x_db y_xn) "c")
(command "pline" (list (+ 10 x_db) (+ 10 y_db)) "w" "0" "0" (list (- x_xn 10) (+ 10 y_db)) (list (- x_xn 10) (- y_xn 10)) (list (+ 10 x_db) (- y_xn 10)) "c")
(command "text" "j" "r" (list (- x_xn 7.0) y_xn) "6.0" "180" (strcat "Y=" (rtos x_xn)))
(command "text" (list x_xn (- y_xn 7.0)) "6" "90" (strcat "X=" (rtos y_xn)))
(setq x_w (+ 250.0 x_xn))
(while (< x_w x_db)
(setq y_w y_xn)
(while (<= y_w y_db)
(setq y_w1 (- y_w 10.0) y_w2 (+ y_w 10.0))
(if (< y_w1 y_xn) (setq y_w1 y_w))
(if (> y_w2 y_db) (setq y_w2 y_w))
(command "line" (list x_w y_w1) (list x_w y_w2) "")
(setq y_w (+ 250.0 y_w))
)
(setq x_w (+ x_w 250.0))
)
(setq y_w (+ 250.0 y_xn))
(while (< y_w y_db)
(setq x_w x_xn)
(while (<= x_w x_db)
(setq x_w1 (- x_w 10.0) x_w2 (+ x_w 10.0))
(if (< x_w1 x_xn) (setq x_w1 x_w))
(if (> x_w2 x_db) (setq x_w2 x_w))
(command "line" (list x_w1 y_w) (list x_w2 y_w) "")
(setq x_w (+ 250.0 x_w))
)
(setq y_w (+ 250.0 y_w))
)
(command "zoom" "e")
(setvar "cmdecho" sblip)
(setvar "blipmode" scmde)
(princ "\n坐标展点图已绘制完毕.") 
(princ "绘图区为(L x H): ")
(princ (+ 20 (- x_db x_xn)))
(princ " X ")
(princ (+ 20 (- y_db y_xn)))
(close nam)
(princ)
)

(princ "\n云秀浪静工作室 Zdxd.LSP 已装载, 使用时请键入 ZDXD .")
(princ) 