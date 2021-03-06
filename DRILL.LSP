(DEFUN C:DRILL ()
;(IF (= (TYPE F1) 'FILE ) "YES"  (STOP))
;(IF (= (TYPE F2) 'FILE ) "YES" (STOP))

(SETQ NY (GETVAR "CLAYER"))
(setq DRSET (findfile "C:/ACAD/ACAD/SUPPORT/DRILL.SET"))
(IF (= DRSET NIL)
    (PROGN
       (PROMPT "\nPLEASE SETTING LAYER:" )
       (SETQ FC (OPEN "C:/ACAD/ACAD/SUPPORT/DRILL.SET" "w"))
       (setq DRILLCNT (GETSTRING T"\nSETTING LAYER OF CONTNIUE LINE ? <0>:"))
       (IF (= DRILLCNT "")
              (WRITE-LINE "0" FC)
              (WRITE-LINE DRILLCNT FC)
       )
       (setq DRILLCEN (GETSTRING T"\nSETTING LAYER OF CENTER LINE ? <CEN>:"))
       (IF (= DRILLCEN "")
              (WRITE-LINE "CEN" FC)
              (WRITE-LINE DRILLCEN FC)
       )
       (setq DRILLHID (GETSTRING T"\nSETTING GUIDE PIN LAYER OF HIDDEN LINE ? <HID>:"))
       (IF (= DRILLHID "")
              (WRITE-LINE "HID" FC)
              (WRITE-LINE DRILLHID FC)
       )
       (CLOSE FC)
    )
)

(IF (/= DRSET NIL)
    (PROGN
       (SETQ FC (OPEN "C:/ACAD/ACAD/SUPPORT/DRILL.SET" "r"))
       (SETQ DRILLCNT (READ-LINE FC))
       (SETQ DRILLCEN (READ-LINE FC))
       (SETQ DRILLHID (READ-LINE FC))
       (IF (OR (= DRILLCNT "") (= DRILLCEN "") (= DRILLHID "")
               (= DRILLCNT NIL) (= DRILLCEN NIL) (= DRILLHID NIL))
           (CLOSE FC)
       )
       (IF (OR (= DRILLCNT "") (= DRILLCEN "") (= DRILLHID "")
               (= DRILLCNT NIL) (= DRILLCEN NIL) (= DRILLHID NIL))
           (PROGN
              (PROMPT "\nPLEASE SETTING LAYER:" )
              (SETQ FC (OPEN "C:/ACAD/ACAD/SUPPORT/DRILL.SET" "w"))
              (setq DRILLCNT (GETSTRING T"\nSETTING LAYER OF CONTNIUE LINE ? <0>:"))
              (IF (= DRILLCNT "")
                  (WRITE-LINE "0" FC)
                  (WRITE-LINE DRILLCNT FC)
              )
              (setq DRILLCEN (GETSTRING T"\nSETTING LAYER OF CENTER LINE ? <CEN>:"))
              (IF (= DRILLCEN "")
                  (WRITE-LINE "CEN" FC)
                  (WRITE-LINE DRILLCEN FC)
              )
              (setq DRILLHID (GETSTRING T"\nSETTING HIDDEN LINE ? <HID>:"))
              (IF (= DRILLHID "")
                  (WRITE-LINE "HID" FC)
                  (WRITE-LINE DRILLHID FC)
              )
           (CLOSE FC)
           )
       )
       (SETQ FC (OPEN "C:/ACAD/ACAD/SUPPORT/DRILL.SET" "r"))
       (SETQ DRILLCNT (READ-LINE FC))
       (SETQ DRILLCEN (READ-LINE FC))
       (SETQ DRILLHID (READ-LINE FC))
       (CLOSE FC)
       (PROMPT "\nG.P CONTINUE OF LAYER IS:" )(PROMPT DRILLCNT)(TERPRI)
       (PROMPT "\nG.P CENTER OF LAYER IS:" ) (PROMPT DRILLCEN)(TERPRI)
       (PROMPT "\nG.P HIDDEN OF LAYER IS:" ) (PROMPT DRILLHID)(TERPRI)
    )
)

(SETQ ANS (strcase (GETSTRING "\nDO YOU WANT TO CHANGE LAST SETTING <Y/N> N:")))
(IF (= ANS "Y")
    (PROGN
       (PROMPT "\nPLEASE SETTING LAYER:" )
       (SETQ FC (OPEN "C:/ACAD/ACAD/SUPPORT/DRILL.SET" "w"))
       (PROMPT "\nCONTINUE OF LAYER " )(PROMPT "<")(PROMPT DRILLCNT) (PROMPT ">:")
       (setq DRILLCNT (GETSTRING T))
       (IF (= DRILLCNT "")
              (WRITE-LINE "0" FC)
              (WRITE-LINE DRILLCNT FC)
       )
       (PROMPT "\nCENTER OF LAYER " )(PROMPT "<")(PROMPT DRILLCEN) (PROMPT ">:")
       (setq DRILLCEN (GETSTRING T))
       (IF (= DRILLCEN "")
              (WRITE-LINE "CEN" FC)
              (WRITE-LINE DRILLCEN FC)
       )
       (PROMPT "\nHIDDEN OF LAYER " )(PROMPT "<")(PROMPT DRILLHID) (PROMPT ">:")
       (setq DRILLHID (GETSTRING T))
       (IF (= DRILLHID "")
              (WRITE-LINE "HID" FC)
              (WRITE-LINE DRILLHID FC)
       )
       (CLOSE FC)
       (SETQ FC (OPEN "C:/ACAD/ACAD/SUPPORT/DRILL.SET" "r"))
       (SETQ DRILLCNT (READ-LINE FC))
       (SETQ DRILLCEN (READ-LINE FC))
       (SETQ DRILLHID (READ-LINE FC))
       (CLOSE FC)
       (PROMPT "\nG.P CONTINUE OF LAYER NOW IS:" )(PROMPT DRILLCNT)(TERPRI)
       (PROMPT "\nG.P CENTER   OF LAYER NOW IS:" ) (PROMPT DRILLCEN)(TERPRI)
       (PROMPT "\nG.P HIDDEN   OF LAYER NOW IS:" ) (PROMPT DRILLHID)(TERPRI)
  )
)


(setq d (getreal "\n How about the drill diameter ?"))
;(SETQ DIST (GETREAL"\n<EXTEND LENGTH>:"))
(SETQ DIST (GETVAR "TEXTSIZE"))
(IF (< DIST 1 )
    (SETQ DIST 0.0393)
    (SETQ DIST 1)
)
(SETQ P1 (GETPOINT"\nFIRST POINT:"))
(SETQ P2 (GETPOINT P1"\nSECOND POINT:"))
(SETQ AG1 (ANGLE P1 P2))
(SETQ AG2 (* PI 0.5))
(SETQ LST (DISTANCE P1 P2)) ;DIST FOR P1 P2
(SETQ DR1 (POLAR (POLAR P1 AG1 0) (+ AG1 AG2) (/ D 2.0)))
(SETQ DR2 (POLAR (POLAR P1 AG1 0) (- AG1 AG2) (/ D 2.0)))
(SETQ DR3 (POLAR (POLAR P1 AG1 LST) (+ AG1 AG2) (/ D 2.0)))
(SETQ DR4 (POLAR (POLAR P1 AG1 LST) (- AG1 AG2) (/ D 2.0)))
(SETQ DR5 (POLAR DR3 (- AG1 (DTR 60)) 2))
(SETQ DR6 (POLAR DR4 (+ AG1 (DTR 60)) 2))
(SETQ INT (INTERS DR3 DR5 DR4 DR6 NIL))
(COMMAND "LAYER" "S" DRILLCNT "")
(COMMAND "LINE" DR1 DR2 "")
(COMMAND "LINE" DR3 DR4 "")
(COMMAND "LINE" DR1 DR3 "")
(COMMAND "LINE" DR2 DR4 "")
(COMMAND "LINE" DR3 INT "")
(COMMAND "LINE" DR4 INT "")
(COMMAND "LAYER" "SET" DRILLCEN "")
(COMMAND "LINE" (POLAR P1 AG1 (* -1 DIST)) (POLAR INT AG1 DIST ) "")

(COMMAND "LAYER" "SET" NY "")
)
