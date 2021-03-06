;;;为了防止文本尺寸过大,本程序已将该程序中所涉及到的文本自型定义
;;;为"STANDARD"型,用户在执行本程序前最好将"STANDARD"字型的宽度因子"Width"
;;;设为0.6或更小.(陈松)

(defun csbj ( / opt gj_oe gj_oc gj_oh gj_oo gj_or gj_ot twid tth)
  (defun gj_er (s)
    (if (/= s "Function cancelled")
      (if (=s "quit / exit abort")
        (princ)
        (princ (strcat "\nError: " s))
      )
    )
    (eval(read U:E))
    (if gj_oe
      (setq *error* gj_oe)
    )
    (if gj_oc (setvar "cmdecho" gj_oc))
    (if gj_oo (setvar "osmode" gj_oo))
    (if gj_oh (setvar "highlight" gj_oh))
    (if gj_or (setvar "orthomode" gj_or))
    (if gj_ob (setvar "blipmode" gj_ob))
    (if gj_ot (setvar "textstyle" gj_ot))
    (if tbh (setq tbh (- tbh 1)))
    (princ)
  )
  (if *error*
    (setq gj_oe *error* *error* gj_er)
    (setq *error* gj_er)
  )
  (setq U:G "(command \"undo\" \"group\")"
        U:E "(command \"undo\" \"en\")"
  )
  (setq gj_oc (getvar "cmdecho"))
  (setq gj_oh (getvar "highlight"))
  (setq gj_oo (getvar "osmode"))
  (setq gj_or (getvar "orthomode"))
  (setq gj_ob (getvar "blipmode"))
  (setq gj_ot (getvar "textstyle"))
  (setvar "cmdecho" 0)
  (setvar "blipmode" 0)
  (setvar "textstyle" "standard")
  (eval(read U:G))
  (princ (strcat "\n画板钢筋,(c) 1996.10.1 by 陈松 -- 南昌. "))
  (gj_ol)
  (if gj_oe (setq *error* gj_oe))
  (eval(read U:E))
  (if gj_oc (setvar "cmdecho" gj_oc))
  (if gj_oh (setvar "highlight" gj_oh))
  (if gj_oo (setvar "osmode" gj_oo))
  (if gj_or (setvar "orthomode" gj_or))
  (if gj_ob (setvar "blipmode" gj_ob))
  (if gj_ot (setvar "textstyle" gj_ot))
  (princ)
)

(if wid nil (setq wid 50))
(if th nil (setq th 300))
;;;
;;; The gj_ol() definition
;;;
(defun gj_ol()
  (while ( /= opt "X")
    (progn
      (initget "A B C D X")
      (setq opt (getkword
        "\nA正筋/B负筋/C钢筋编号/D参数设置/X退出<A正筋>: "))
      (if opt nil (setq opt "A"))
      (if (= opt "D")
        (progn
          (setq twid (getreal (strcat "\n钢筋线粗<" (rtos wid 2) ">: ")))
          (if twid (setq wid twid))
          (setq tth (getreal (strcat "\n文字高度<" (rtos th 2) ">: ")))
          (if tth (setq th tth))
        )
      )
      (cond
        ((= opt "A")   (gj_zj wid th) )
        ((= opt "B")   (gj_fj wid th) )
        ((= opt "C")   (gj_bh wid th) )
      )
    )
  )
)

;;;
;;;The gj_bh() funtion denifition
;;;
(if bh nil (setq bh 1))
(if a_b nil (setq a_b 0.0))

(defun gj_bh (wid th / tbh bhb pc ta_b)
  (setvar "osmode" 0)
  (if (/= bhb bh) (setq bhb (- bh 1)))
  (setq tbh (getint (strcat "\n钢筋编号<" (itoa bhb) ">: ")))
  (if tbh (setq bhb tbh))
  (setq ta_b (getangle (strcat "\n编号角度<" (rtos a_b 2 1) ">: ")))
  (if ta_b (setq a_b ta_b))
  (setq pc T)
  (while (/= pc nil)
    (progn
      (setq pc (getpoint "\n编号位置<回车退出>: "))
      (if (/= pc nil)
        (progn
          (command "circle" pc (* th 0.667))
          (setq pc (polar pc (- a_b (/ pi 2)) (* th 0.45)))
          (command "text" "c" pc (* th 0.9) (/ (* a_b 180) pi) (itoa bhb))
        )
      )
    )
  )
)

;;;
;;;Defun gj_zj
;;;
(defun gj_zj (wid th / p1 p2 p3 p4 p5 p6 tp jd jj ang tbh e1 e2 e3)
  (setvar "osmode" 0)
  (setvar "orthomode" 1)
  (setvar "blipmode" 1)
  (while (= p1 nil)
    (setq p1 (getpoint "\n请输入第一点:"))
  )
  (while (= p2 nil)
    (setq p2 (getpoint p1 "\n请输入第二点:"))
  )
  (setvar "blipmode" 0)
  (setq ang (angle p1 p2))
  (if (and (> ang (/ pi 2)) (<= ang (* pi 1.5)))
    (setq tp p1 p1 p2 p2 tp ang (angle p1 p2) )
  )
  (if (<= ang (/ pi 2))
    (setq p1 (polar p1 (+ pi ang) (* wid 1.5))
          p2 (polar p2 ang (* wid 1.5))
          p3 (polar p1 (+ ang (/ pi 2)) (* wid 2))
          p4 (polar p2 (+ ang (/ pi 2)) (* wid 2))
          p5 (polar p3 ang (* wid 1.5))
          p6 (polar p4 (+ ang pi) (* wid 1.5))
    )
  )
  (if (> ang (* pi 1.5))
    (setq p1 (polar p1 ang (* wid 1.5))
          p2 (polar p2 (- ang pi) (* wid 1.5))
          p3 (polar p1 (- ang (* pi 1.5)) (* wid 2))
          p4 (polar p2 (- ang (* pi 1.5)) (* wid 2))
          p5 (polar p3 ang (* wid 1.5))
          p6 (polar p4 (- ang pi) (* wid 1.5))
    )
  )
  (command "_pline" p5 "w" wid wid p3 "a" p1 "l" p2 "a" p4 "l" p6 "")
  (setq jd (getstring "\n钢筋直径(0=取消)<8>: "))
  (if (/= jd "0")
    (progn
      (if (= jd "") (setq jd "8"))
      (setq jj (getstring "\n钢筋间距<200>: "))
      (if (= jj "") (setq jj "200"))
    )
  )
  (setq tbh (getint (strcat "\n钢筋编号(0=取消)<" (itoa bh) ">: ")))
  (if (and (/= tbh nil) (/= tbh 0)) (setq bh tbh))
  (if (/= tbh 0)
    (progn
      (if (<= ang (/ pi 2))
        (progn
          (setq p1 (polar p1 ang (* th 1.5)))
          (setq p1 (polar p1 (+ ang (/ pi 2)) (* th 0.667)))
          (command "_circle" p1 (* th 0.667))
          (setq e1 (entlast))
          (setq p1 (polar p1 (- ang (/ pi 2)) (* th 0.4)))
          (command "_text" "c" p1 (* th 0.9) (/ (* ang 180) pi) (itoa bh) )
          (setq e2 (entlast))
        )
      )
      (if (> ang (* pi 1.5))
        (progn
          (setq p1 (polar p1 ang (* th 1.5)))
          (setq p1 (polar p1 (- ang (* pi 1.5)) (* th 0.667)))
          (command "_circle" p1 (* th 0.667))
          (setq e1 (entlast))
          (setq p1 (polar p1 (- ang (/ pi 2)) (* th 0.4)))
          (command "_text" "c" p1 (* th 0.9) (/ (* ang 180) pi) (itoa bh) )
          (setq e2 (entlast))
        )
      )
    (setq bh (+ bh 1))
    )
  )
  (if (/= jd "0")
    (progn
      (setq jd (strcat "%%130" jd "@" jj))
      (setq p1 (polar p1 ang th))
      (command "_text" p1 th (/ (* ang 180) pi) jd)
      (setq e3 (entlast))
    )
  )
  (if (and (/= jd "0") (/= tbh 0) )
    (progn
      (princ "\n文字位置: ")
      (setvar "highlight" 1)
      (setvar "orthomode" 0)
      (setvar "blipmode" 1)
      (command "_move" e1 e2 e3 "" p1 pause)
    )
  )
  (if (and (/= jd "0") (= tbh 0))
    (progn
      (princ "\n文字位置: ")
      (setvar "highlight" 1)
      (setvar "orthomode" 0)
      (setvar "blipmode" 1)
      (command "_move" e3 "" p1 pause)
    )
  )
  (if (and (= jd "0") (/= tbh 0))
    (progn
      (princ "\n文字位置: ")
      (setvar "highlight" 1)
      (setvar "orthomode" 0)
      (setvar "blipmode" 1)
      (command "_move" e1 e2 "" p1 pause)
    )
  )
)
;;;
;;;(defun gj_fj)
;;;
(defun gj_fj(wid th / ll lr pz p1 p2 p3 p4 p5 p6 p11 p12 p21 p22 p31 p32 e1
                      e2 e3 tbh ang ang2 jd jj yn)
  (setvar "blipmode" 1)
  (setvar "osmode" 0)
  (setvar "orthomode" 0)
  (while (< ll 0)
    (progn
      (setq ll (getdist "\n钢筋左(下)边长度<0>: "))
      (if ll nil (setq ll 0))
    )
  )
  (while (< lr 0)
    (progn
      (setq lr (getdist (strcat "\n钢筋右(上)边长度<" (rtos ll) ">: ")))
      (if lr nil (setq lr ll))
    )
  )
  (if (not (and (= ll 0) (= lr 0)))
    (progn
      (while (= pz nil)
        (setq pz (getpoint "\n钢筋位置: "))
      )
      (setvar "orthomode" 1)
      (setq ang (getangle pz "\n钢筋角度<90>: "))
      (if ang nil (setq ang (/ pi 2)))
      (if (or (> ang (* pi 1.5)) (<= ang (/ pi 2))) (setq ang (+ ang pi)))
      (if (and (= ll 0) (> lr 0))
        (setq p1 pz p2 (polar pz (- ang pi) lr))
      )
      (if (and (> ll 0) (= lr 0))
        (setq p2 pz p1 (polar pz ang ll))
      )
      (if (and (> ll 0) (> lr 0))
        (setq p1 (polar pz ang ll) p2 (polar pz (- ang pi) lr))
      )
      (setq ang2 (+ ang (/ pi 2))
            p3 (polar p1 ang2 (* wid 3))
            p4 (polar p2 ang2 (* wid 3))
      )
    )
  )
  (setvar "osmode" 0)
  (if p1
    (progn
      (setvar "blipmode" 0)
      (command "_pline" p3 "w" wid wid p1 p2 p4 "")
      (setvar "blipmode" 1)
      (initget "Yes No 0")
      (setq yn (getkword "\n是否改变钢筋的标注长度(0=不标注)[Y,N]<N>: "))
      (if (/= yn "0")
        (progn
          (if (= yn "Yes")
            (progn
              (if (/= ll 0)
                (setq ll (getdist (strcat "\n钢筋左(下)的标注长度<" (rtos ll 2)
                                        ">: "))))
              (if (/= lr 0)
                (setq lr (getdist (strcat "\n钢筋右(上)的标注长度<" (rtos lr 2)
                                        ">: "))))
            )
          )
          (if (or (= p1 pz) (= p2 pz))
            (setq p1 (polar p3 ang2 (/ th 3))
                  p2 (polar p4 ang2 (/ th 3))
                  p3 (polar p1 ang2 (* th 1.4))
                  p4 (polar p2 ang2 (* th 1.4))
            )
            (setq p1 (polar p3 ang2 (/ th 3))
                  p2 (polar pz ang2 (+ (* wid 3) (/ th 3)))
                  p3 (polar p4 ang2 (/ th 3))
                  p4 (polar p1 ang2 (* th 1.4))
                  p5 (polar p2 ang2 (* th 1.4))
                  p6 (polar p3 ang2 (* th 1.4))
            )
          )
          (setvar "blipmode" 0)
          (if p5
            (progn
              (command "_line" p1 p4 "")
              (command "_line" p2 p5 "")
              (command "_line" p3 p6 "")
              (setq p1 (polar p1 ang2 th)
                    p2 (polar p2 ang2 th)
                    p3 (polar p3 ang2 th)
              )
              (command "_line" p1 p3 "")
              (setq p11 (polar p1 (- ang2 (/ pi 4)) (* wid 1.5))
                    p12 (polar p1 (- ang2 (* pi 1.25)) (* wid 1.5))
                    p21 (polar p2 (- ang2 (/ pi 4)) (* wid 1.5))
                    p22 (polar p2 (- ang2 (* pi 1.25)) (* wid 1.5))
                    p31 (polar p3 (- ang2 (/ pi 4)) (* wid 1.5))
                    p32 (polar p3 (- ang2 (* pi 1.25)) (* wid 1.5))
              )
              (command "_pline" p11 "w" wid wid p12 "")
              (command "_pline" p21 "w" wid wid p22 "")
              (command "_pline" p31 "w" wid wid p32 "")
              (setq p1 (polar p1 (- ang pi) (/ (distance p1 p2) 2)))
              (setq p1 (polar p1 (- ang (/ pi 2)) (* th 0.166)))
              (setq p2 (polar p2 (- ang pi) (/ (distance p2 p3) 2)))
              (setq p2 (polar p2 (- ang (/ pi 2)) (* th 0.166)))
              (command "_text" "c" p1 th (/ (* (- ang pi) 180) pi) (rtos ll 2))
              (command "_text" "c" p2 th (/ (* (- ang pi) 180) pi) (rtos lr 2))
            )
            (progn
              (command "_line" p1 p3 "")
              (command "_line" p2 p4 "")
              (setq p1 (polar p1 ang2 th)
                    p2 (polar p2 ang2 th)
              )
              (command "_line" p1 p2 "")
              (setq p11 (polar p1 (- ang2 (/ pi 4)) (* wid 1.5))
                    p12 (polar p1 (- ang2 (* pi 1.25)) (* wid 1.5))
                    p21 (polar p2 (- ang2 (/ pi 4)) (* wid 1.5))
                    p22 (polar p2 (- ang2 (* pi 1.25)) (* wid 1.5))
              )
              (command "_pline" p11 "w" wid wid p12 "")
              (command "_pline" p21 "w" wid wid p22 "")
              (if (= ll 0) (setq ll lr))
              (setq p1 (polar p1 (- ang pi) (/ (distance p1 p2) 2)))
              (setq p1 (polar p1 (- ang (/ pi 2)) (* th 0.166)))
              (command "_text" "c" p1 th (/ (* (- ang pi) 180) pi) (rtos ll 2))
            )
          )
        )
      )
      (setq jd (getint "\n钢筋直径(0=取消)<8>: "))
      (if (/= jd 0)
        (progn
          (if jd nil (setq jd 8))
          (setq jj (getint "\n钢筋间距<200>: "))
          (if jj nil (setq jj 200))
        )
      )
      (setq tbh (getint (strcat "\n钢筋编号(0=取消)<" (itoa bh) ">: ")))
      (if (and (/= tbh 0) (/= tbh nil)) (setq bh tbh))
      (if (/= tbh 0)
        (progn
          (setq ang2 (- ang (/ pi 2)))
          (setq pz (polar pz ang2 (* th 0.667)))
          (command "_circle" pz (* th 0.667))
          (setq e1 (entlast))
          (setq ang2 (- ang2 pi))
          (setq pz (polar pz ang2 (* th 0.45)))
          (command "_text" "c" pz (* th 0.9) (/ (* (- ang pi) 180) pi)
                   (itoa bh))
          (setq e2 (entlast))
          (setq bh (+ bh 1))
        )
      )
      (if (/= jd 0)
        (progn
          (setq ang2 (- ang pi))
          (setq pz (polar pz ang2 (* th 0.833)))
          (setq jd (strcat "%%130" (itoa jd) "@" (itoa jj)))
          (command "_text" pz th (/ (* (- ang pi) 180) pi) jd)
          (setq e3 (entlast))
        )
      )
      (if (or (/= tbh 0) (/= jd 0))
        (progn
          (setvar "highlight" 1)
          (setvar "orthomode" 0)
          (setvar "blipmode" 1)
          (princ "\n编号位置: ")
          (if (= tbh 0) (command "_move" e3 "" pz pause))
          (if (= jd 0) (command "_move" e1 e2 "" pz pause))
          (if (and (/= tbh 0) (/= jd 0))
            (command "_move" e1 e2 e3 "" pz pause)
          )
        )
      )
    )
  )
)
;;;
;;; The C: function definition
;;;
(defun c:bj     () (csbj))
(princ "\n\tC:CSBJ 已经加载. 键入 BJ 执行命令.")
(princ)

