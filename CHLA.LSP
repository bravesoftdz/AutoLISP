(defun c:chla ()
(menucmd "s=sel")
(prompt "Change Layer Name <")(princ lay)(prompt "> :")
(setq lay (getstring))
(if (= lay "") (setq lay lay1))
(setq lay1 lay)
(setq a (ssget))
(setq b (sslength a))
(setq d 0)
(repeat b
(setq c (ssname a d))
(setq q (entget c))
(setq e (assoc 8 (entget c)))
(setq f (subst (cons 8 lay) e q))
(entmod f)
(setq d (+ d 1))
)(princ))
