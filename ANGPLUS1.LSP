DEFUN C:ANGPLUS1
(SETQ TR1 (GETSTRING"\nINPUT VALUE:"))
(SETQ DEG (GETSTRING"\nINPUT DGREE:"))
(SETQ ANS (GETSTRING T"\nPLUS (+) OR MULS (-) :"))
(SETQ TP (GETPOINT"\n INSERT POINT :"))
(SETQ TR2 (STRCAT DEG "%%D"))
(SETQ TZ1 (GETVAR "TEXTSIZE"))
(SETQ TZ (/ (GETVAR "TEXTSIZE") 2.0))
(SETQ STRL (STRLEN TR1))
(COMMAND "TEXT" TP TZ1 "" TR1)
(COMMAND "TEXT" (LIST (+ (CAR TP) (* (+ STRL 0.5) TZ1)) (+ (CADR TP) TZ1))  TZ "" TR2)
(COMMAND "CIRCLE" (LIST (+ (CAR TP) (*  STRL TZ1)) (+ (CADR TP) (* 1.2 TZ1)))  (* TZ 0.65))
(SETQ RC (LIST (+ (CAR TP) (*  STRL TZ1)) (+ (CADR TP) (* 1.2 TZ1))))
 (IF (= ANS "+")
     (COMMAND "TEXT" "M" RC TZ "" "+")
     (COMMAND "TEXT" "M" RC TZ "" "-")
 )
 (COMMAND "SETVAR" "TEXTSIZE" TZ1)
