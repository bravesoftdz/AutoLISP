; *************************************************************************
;                              AXROT.LSP
;
; By Jan S. Yoder                                          May 11, 1988
;
; A routine to do 3 axis rotation of a selection set
;
; *************************************************************************

; Internal error handler

(defun axerr (s)                      ; If an error (such as CTRL-C) occurs
                                      ; while this command is active...
   (if (/= s "Function cancelled")
       (princ (strcat "\nError: " s))
   )
   (setq *error* olderr)              ; restore old *error* handler
   (setvar "gridmode" ogm)            ; restore saved modes
   (setvar "highlight" ohl)
   (setvar "ucsfollow" oucsf)
   (command "undo" "e")               ; complete undo group
   (setvar "cmdecho" oce)
   (princ)
)

; Main program

(defun c:axrot (/ olderr obpt ogm ohl oucsf ssel kwd dr bpt)
   (setq olderr *error*
       *error* axerr)
   (setq oce   (getvar "cmdecho") 
         ogm   (getvar "gridmode")
         ohl   (getvar "highlight")
         oucsf (getvar "ucsfollow"))

   (setvar "cmdecho" 0)
   (command "undo" "group")
   (setvar "gridmode" 0)
   (setvar "ucsfollow" 0)

   (setq ssel (ssget))

   (setvar "highlight" 0)

   (initget 1 "X Y Z")
   (setq kwd (getkword "\nAxis of rotation X/Y/Z: "))
   (setq dr (getreal "\nDegrees of rotation <0>: "))
   (if (null dr)
      (setq dr 0)
   )
   (setq bpt (getpoint "\nBase point <0,0,0>: "))
   (if (null bpt)
      (setq bpt (list 0 0 0))
   )
   (setq bpt (trans bpt 1 0))
   (cond 
        ((= kwd "X") (command "ucs" "Y" "90"))
        ((= kwd "Y") (command "ucs" "X" "-90"))
        ((= kwd "Z") (command "ucs" "Z" "0"))
   )
   (setq bpt (trans bpt 0 1))
   (command "rotate" ssel "" bpt dr)

   (command "ucs" "p")                ;restore previous ucs
   (setvar "gridmode" ogm)            ;restore saved modes
   (setvar "highlight" ohl)
   (setvar "ucsfollow"  LECT   DWG           6q��5+!  LECT   DWG           6q��5+!  LECT   DWG           6q��5+!  LECT   DWG           6q��5+!  LECT   D