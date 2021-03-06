DEFUN C:LCHG13
;SET LAYER
(COMMAND "SETVAR" "CMDECHO" 0)
;(IF (= (TYPE F1) 'FILE ) "YES"  (STOP))
;(IF (= (TYPE F2) 'FILE ) "YES" (STOP))
(setq SET13 (findfile "/ACAD/HON/SET/SET13.SET"))
(IF (= SET13 NIL)
    (PROGN
       (PROMPT "\nPLEASE SETTING LAYER:" )
       (SETQ FC (OPEN "/ACAD/HON/SET/SET13.SET" "w"))
       (setq SETL13 (GETSTRING T"\nSETTING LAYER ? <13>:"))
       (IF (OR (= SETL13 "") (= SETL13 NIL))
              (WRITE-LINE "13" FC)
              (WRITE-LINE SETL13 FC)
       )
       (CLOSE FC)
    )
)

(IF (/= SET13 NIL)
    (PROGN
       (SETQ FC (OPEN "/ACAD/HON/SET/SET13.SET" "r"))
       (SETQ SETL13 (READ-LINE FC))
       (IF (OR (= SETL13 "") (= SETL13 NIL))
           (CLOSE FC)
       )
       (IF (OR (= SETL13 "") (= SETL13 NIL))
           (PROGN
              (PROMPT "\nPLEASE SETTING LAYER:" )
              (SETQ FC (OPEN "/ACAD/HON/SET/SET13.SET" "w"))
              (setq SETL13 (GETSTRING T"\nSETTING LAYER ? <13>:"))
              (IF (= SETL13 "")
                  (WRITE-LINE "13" FC)
                  (WRITE-LINE SETL13 FC)
              )
           (CLOSE FC)
           )
       )
       (SETQ FC (OPEN "/ACAD/HON/SET/SET13.SET" "r"))
       (SETQ SETL13 (READ-LINE FC))
       (CLOSE FC)
       (PROMPT "\nLAYER NAME IS:" )(PROMPT SETL13)(TERPRI)
       (SETQ LR SETL13)
       (C:QCHNG)
    )
)
