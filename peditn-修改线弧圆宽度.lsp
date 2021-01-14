;;;  peditn.lsp
;;;  (C)  给排水组 
;;;  by zhuxiaofeng
;;;  1995,10,20 (1版)
;;;  1997,5,15  (2版)
;;;  该程序可修改线,弧,圆及多义线的宽度
(defun C:pn (/ p l n e q w a m b layer0 color0 linetype0 layer1 color1 linetype1 rad-out rad-in)
 (command "undo" "begin")
  (setq oldblp (getvar "blipmode")
        oldech (getvar "cmdecho")
        olderr *error*
        linetype1 (getvar "celtype")
        layer1 (getvar "clayer")
        color1 (getvar "cecolor")
  )
  (setvar "blipmode" 0) 
  (setvar "cmdecho" 0)
  (defun *error* (msg)
    (princ "\n") 
    (princ msg)
    (setvar "blipmode" oldblp)
    (setvar "cmdecho" oldech)
    (setq *error* olderr)
    (princ)
  )  
  (prompt "\n请选择要改变宽度的线,弧,圆及多义线.")
  (setq p (ssget))
  (setq w (getreal "\n请输入宽度<50>:"))
  (if (not w) (setq w 50))
  (setq l 0 m 0 n (sslength p))
  (while (< l n)
    (setq q (ssname p l))
    (setq ent (entget q))
    (setq b (cdr (assoc 0 ent)))
    (if (member b '("LINE" "ARC"))
      (progn 
        (command "PEDIT" q "y" "w" w "x") 
        (setq m (+ 1 m))
      ) 
    )
    (if (= "LWPOLYLINE" b)
      (progn 
        (command "PEDIT" q "w" w "x") 
        (setq m (+ 1 m))
      ) 
    )
    (if (= "CIRCLE" b)
      (progn 
        (if (assoc 6 ent) (setq linetype0 (cdr (assoc 6 ent))) (setq linetype0 "bylayer"))
        (setq layer0 (cdr (assoc 8 ent)))
        (if (assoc 62 ent) (setq color0 (cdr (assoc 62 ent))) (setq color0 "bylayer"))
        (setq center0 (cdr (assoc 10 ent)))
        (setq radius0 (cdr (assoc 40 ent)))
        (setq diameter0 (* 2 radius0))
        (entdel q)
        (command "color" color0)
        (command "layer" "s" layer0 "")
        (command "linetype" "s" linetype0 "")
        (if (> w diameter0)
          (progn 
            (princ "\n\t 因线宽大于圆的直径，故将该圆填充")
            (princ)
            (setq rad-out (* 2 radius0)
                  rad-in 0
            )
          )
        )
        (if (<= w diameter0)
          (progn 
            (setq rad-out (+ (* 2 radius0) w) 
                  rad-in (- (* 2 radius0) w)
            )
          )
        )
        (command "donut" rad-in rad-out center0 "")
        (setq m (+ 1 m))
      )
    ) 
    (setq l (+ 1 l))
  )
  (if (= 0 m)
    (progn 
     (princ "\n\t  没有任何线,弧,圆及多义线被选中")
      (princ)
    )
  )
  (setvar "blipmode" oldblp)
  (setvar "cmdecho" oldech)
  (setq *error* olderr)
  (command "color" color1)
  (command "layer" "s" layer1 "")
  (command "linetype" "s" linetype1 "")
 (command "undo" "end")
  (princ)
)
(princ "\n\t  线宽编辑程序,  (c) 1997 ")
(princ "\n\t  c:Peditn 已加载; 以Pn启动命令.\n")
(princ)
