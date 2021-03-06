(defun C:qls()
 (setq os (getvar "osmode"))
 (setq o(getpoint "\n 输入插入点:"))
 (setq d0(getreal "\n 输入螺栓规格:"))
 (setq l0(getdist o  "\n 输入螺栓长度:"))
 (SETQ SC(GETREAL "\n 输入比例系数:"))
 (setq ang1(getangle o "\n 输入旋转角度:"))
 (setq zx(getstring "\n 是否要中心线(Yes/<No>):"))
 (setq os (getvar "osmode"))
 (command "osmode" 0)
 (setq ang(/ (* 180 ang1) pi))
 (cond ((= d0 5) (setq e0 8.63) (setq k0 3.5) (setq a0 3.2))
       ((= D0 6) (setq E0 11.0) (setq k0 4.0) (setq a0 4))
       ((= D0 8) (setq E0 14.4) (setq k0 5.3) (setq a0 5))
       ((= D0 10) (setq E0 17.8) (setq k0 6.4) (setq a0 6))
       ((= D0 12) (setq E0 20.0) (setq k0 7.5) (setq a0 7))
       ((= D0 16) (setq E0 26.8) (setq k0 10.0) (setq a0 8))
       ((= D0 20) (setq E0 33.0) (setq k0 12.5) (setq a0 10))
       ((= D0 24) (setq E0 39.6) (setq k0 15.0) (setq a0 12))
       ((= D0 30) (setq E0 50.9) (setq k0 18.7) (setq a0 14))
  )
  (SETQ D(* d0 sc))
  (setq e(* e0 sc))
  (setq k(* k0 sc))
  (setq a(* a0 sc))
  (setq l(* l0 sc))
  (setq k1(SQRT (- (* 2.25 (* d d)) (/ (* e e) 16))))
  (setq h(- (* 1.5 d) k1))
  (setq r1 (+ (* h h) (/ (* e e) 64)))
  (setq r (/ (/ r1 2) h))
  (setq P1 (list 0 (/ e 2)))
  (setq p2 (list 0 (- 0 (/ e 2))))
  (command "ucs" "o" o)
  (command "ucs" "z" ang)
  (command "line" p1 p2 "")
  (setq P3 (list (- (* 1.5 d) (+ k k1)) (/ e 4)))
  (setq p4 (list (- (* 1.5 d) (+ k k1)) (- 0 (/ e 4))))
  (setq C1 (list (- (* 1.5 d) k) 0))
  (command "arc" p3 "c" c1 p4)
  (setq p5 (list 0 (/ e 4)))
  (setq p6 (list 0 (- 0 (/ e 4))))
  (command "line" p3 p5 "")
  (command "line" p4 p6 "")
  (setq p7 (list (- (* 1.5 d) (+ k k1)) (/ e 2)))
  (setq c2 (list (- r k) (* 0.375 e)))
  (command "arc" p7 "c" c2 p3)
  (setq p8 (list (- (* 1.5 d) (+ k k1)) (- 0 (/ e 2))))
  (setq c3 (list (- r k) (- 0 (* 0.375 e))))
  (command "arc" p4 "c" c3 p8)
  (command "line" p7 p1 "")
  (command "line" P8 p2 "")
  (setq p9 (list (- 0 K) (* 0.375 e)))
  (setq p10 (list (- 0 k) (- 0 (* 0.375 e))))
  (command "line" p9 p10 "")
  (setq p11 (list 0 (/ d 2)))
  (setq p12 (list (- l (* d 0.075)) (/ d 2)))
  (command "line" p11 p12 "")
  (setq p13 (list 0 (- 0 (/ d 2))))
  (setq p14 (list (- l (* d 0.075)) (- 0 (/ d 2))))
  (command "line" p13 p14 "")
  (setq P19 (list a (/ d 2)))
  (setq p20 (list a (- 0 (/ d 2))))
  (command "line" p19 p20 "")
  (SETQ P15 (list a (* 0.425 d)))
  (setq p16 (list l (*  0.425 d)))
  (setq p17 (list a (- 0 (* 0.425 D))))
  (setq p18 (list l (- 0 (* 0.425 d))))
  (command "line" p15 p16 "")
  (command "line" p17 p18 "")
  (command "line" p15 p11 "") 
  (command "line" p12 p16 "")
  (command "line" p14 p18 "") 
  (command "line" p17 p13 "")
  (command "line" p16 p18 "")
  (command "line" p12 p14 "")
  (cond ((or (= zx "y") (= zx "Y"))
        (setq zx1 (list (- -3 k) 0))
        (setq zx2 (list (+ l 3) 0))
        (command "line" zx1 zx2 ""))
   )
  (command "ucs" "z" (- 0 ang))
  (command "ucs" "w")
  (command "osmode" os)
  (COMMAND "REDRAWALL")
  (COMMAND "REGEN")
  (princ)
)

