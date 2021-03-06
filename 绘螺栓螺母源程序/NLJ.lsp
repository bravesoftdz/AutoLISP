(defun C:nlj()
 (setq os (getvar "osmode"))
 (setq o(getpoint "\n 输入插入点:"))
 (setq d0(getreal "\n 输入内六角圆柱头螺钉规格:"))
 (setq l0(getdist o  "\n 输入内六角圆柱头螺钉长度:"))
 (SETQ SC(GETREAL "\n 输入比例系数:"))
 (setq ang1(getangle o "\n 输入旋转角度:"))
 (setq os (getvar "osmode"))
 (command "osmode" 0)
 (setq ang(/ (* 180 ang1) pi))
 (cond ((= d0 5) (setq e0 4.58) (setq k0 8.5) (setq r0 1))
       ((= D0 6) (setq E0 5.72) (setq k0 10.0) (SETQ R0 1.2))
       ((= D0 8) (setq E0 6.86) (setq k0 13.0) (SETQ R0 1.2))
       ((= D0 10) (setq E0 9.12) (setq k0 16.0) (SETQ R0 1.5))
       ((= D0 12) (setq E0 11.43) (setq k0 18.0) (SETQ R0 1.5))
       ((= D0 16) (setq E0 16) (setq k0 24.0) (SETQ R0 2))
       ((= D0 20) (setq E0 19.44) (setq k0 30.0) (SETQ R0 2.5))
       ((= D0 24) (setq E0 21.73) (setq k0 36.0) (SETQ R0 3))
       ((= D0 30) (setq E0 25.15) (setq k0 45.0) (SETQ R0 3.5))
  )
  (SETQ R(* R0 SC))
  (SETQ D(* d0 sc))
  (setq dr (/ d 2))  
  (setq d4 (* d 0.425))
  (setq e(* e0 sc))
  (setq k(* k0 sc))
  (setq kr(/ k 2))
  (setq l(* l0 sc))
  (setq p1 (list (- 0 d) (- kr r)))
  (setq p2 (list (- 0 d) (- r kr)))
  (setq p4 (list 0 (- 0 kr)))
  (setq p3 (list (- r d) (- 0 kr)))
  (setq p5 (list 0 kr))
  (setq p6 (list (- r d) kr))
  (setq c1 (list (- r d) (- kr r)))
  (setq c2 (list (- r d) (- r kr)))
  (command "ucs" "o" o)
  (command "ucs" "z" ang)
  (command "pline" p1 "w" 0 0 p2 "a" "ce" c2 p3 "l" p4 p5 p6 "a" "ce" c1 p1 "")
  (setq dj (* d 0.075))
  (setq p7 (LIST 0 (- 0 dr)))
  (setq p8 (list (- l dj) (- 0 dr)))
  (setq p9 (list l (- 0 d4)))
  (setq p10 (list l d4))
  (setq p11 (list (- l dj) dr))
  (setq p12 (list 0 dr))
  (setq p13 (list 0 d4))
  (setq p14 (list 0 (- 0 d4)))
  (command "line" p7 p8 p9 p10 p11 p12 "")
  (command "line" p13 p10 "")
  (command "line" p14 p9 "")
  (command "line" p11 p8 "")
  (command "ucs" "z" (- 0 ang))
  (command "ucs" "w")
  (command "osmode" os)
  (COMMAND "REDRAWALL")
  (COMMAND "REGEN")
  (princ)
)

