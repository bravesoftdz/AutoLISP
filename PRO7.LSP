
(defun C:ct (/  e os str n a h ent eng )
   (setvar "cmdecho" 0)
   (setq str (getstring "\nSelect option < Text / Height / Style :"))
   (while (/= (strlen str) 0)
    (if (or (= str "T") (= str "t") (= str "Text") (= str "text"))
    (progn
       (setq os (entsel "\nSelect the text desired to change :"))
       (while (not (null os))
       (redraw (car os) 3)
         (if (= "TEXT"  (cdr (assoc 0 (setq e (entget (car os))))))
               (progn
                       (setq as (assoc 1 e))
                       (setq as1 (cdr as))
                       (setq ns (getstring T (strcat "\nEnter the text to change <" as1 ">:" )))
                  (if (/= "" ns)(progn (setq e (subst (cons 1 ns) as e))
                                        (entmod e)
                                  )
                  )
               )
               (progn
                 (princ "The entity is not [TEXT] !")
                 (princ (chr 7))(princ (chr 7))(princ (chr 7))
               )
         )
         (setq os (entsel "\nSelect the text desired to change :"))
       )
     (terpri)
    )
    (progn
      (princ "Select object to be changed :")
    ;  (command "select" pause)
      (setq sset (ssget))
      (setq n (sslength sset))
      (setq a 1)
      (cond
         ((or (= str "H") (= str "h") (= str "Height") (= str "height"))
         (setq h (getreal "\nInput the height to change :"))
         (while (<= a n)
            (setq ent (ssname sset (- a 1)))
            (setq eng (entget ent))
            (setq eng (subst (cons 40 h) (assoc 40 eng) eng))
            (entmod eng)
            (setq a (+ a 1))
          )
         )
         ((or (= str "S") (= str "s") (= str "Style") (= str "style"))
         (setq s (strcase (getstring "\nInput the style to change :")))
         (while (<= a n)
            (setq ent (ssname sset (- a 1)))
            (setq eng (entget ent))
            (setq eng (subst (cons 7 s) (assoc 7 eng) eng))
            (entmod eng)
            (setq a (+ a 1))
          )
         )
         )
    )
    )
   (setq str (getstring "\nSelect option < Text / Height / Style :"))
   )
     (setvar "cmdecho" 1)
 )

