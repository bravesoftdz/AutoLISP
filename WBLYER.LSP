;Copy the entities having the same layer of selected entity
(DEFUN C:WBLYER (/ D1 D2 D3 D4)
;(IF (= (TYPE F1) 'FILE ) "YES"  (STOP))
;(IF (= (TYPE F2) 'FILE ) "YES" (STOP))
  (SETQ D1 (CDR (ASSOC 8 (ENTGET (CAR (ENTSEL))))))
  (SETQ D2 (SSGET "X" (LIST (CONS 8 D1))))
  (IF D2
    (PROGN
      (PROMPT "\nAll entities in layer ")
      (princ D1)
      (PROMPT " will to be written to hard disk...")
      (SETQ D3 (GETSTRING "\nFile name:"))
      (SETQ D4 (GETPOINT "\nInsertion base point:"))
      (SETVAR "CMDECHO" 0)
      (COMMAND "WBLOCK" D3 "" D4 D2 "")
      (SETVAR "CMDECHO" 1)
      (PRINC)
    )
  )
)
