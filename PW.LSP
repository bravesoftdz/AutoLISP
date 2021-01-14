;;;Zpm-pw.lsp

;;;�����������޸�line,pline,arc,circle�ߵĿ���
;;;-------------------------------------------------------------------
;;;===================================================================
;;;��pline�ߵĿ���
(defun pl_e (pline width)
  (command "pedit" pline "w" width "")
)
;;;===================================================================
;;;��line,arc�߿���                   
(defun l_e (line width)
  (command "pedit" line "" "w" width "")
)
;;;===================================================================
;;;��circle����
(defun pc_w (circle width / ed la cen rad d1 d2)
  (setq ed (entget circle))		;ȡ��ʵ�������
  (setq la (cdr (assoc 8 ed)))		;���Բ�ĵ�ǰ��
  (setq cen (cdr (assoc 10 ed)))	;���Բ��Բ��
  (setq cen (trans cen circle 1))	;��Բ������CEN��Ŀ����ϵ
					;ת����ǰ�û�����ϵ
  (setq rad (cdr (assoc 40 ed)))	;���Բ�İ뾶
  (setq d1 (- (+ rad rad) width))	;�ھ�
  (setq d2 (+ (+ rad rad) width))	;�⾶
  (command "layer" "s" la "")
  (entdel circle)
  (command "donut" d1 d2 cen "")
)
;;;===================================================================
(defun c:pw (/ osm width ss number i ename etype)
  (setvar "cmdecho" 0)
  (setq osm (getvar "osmode"))
  (setvar "osmode" 0)

  (if (null default-w)
    (setq default-w "0.00000000")
  )
  (setq width (getreal (strcat "�������߿�<" default-w ">:")))
  (if (null width)
    (setq width (distof default-w))
    (setq default-w (rtos width 2 8))
  )
  (print)
  (prompt "��ѡ�����")
  (setq ss (ssget))
  (if (null ss)
    (princ)
    (progn
      (setq number (sslength ss))
      (setq i 0)
      (repeat number
	(progn
	  (setq ename (ssname ss i))
	  (setq etype (cdr (assoc 0 (entget ename))))
	  (if
	    (= etype "CIRCLE")
	     (pc_w ename width)
	     (if
	       (or (= etype "LWPOLYLINE") (= etype "POLYLINE"))
		(pl_e ename width)
		(if
		  (or (= etype "LINE") (= etype "ARC"))
		   (l_e ename width)
		);END IF
	     );END IF
	  );END IF
	  (setq i (1+ i))
	);END PROGN
      );END REPEAT
    );END PROGN
  );END IF

  (setvar "cmdecho" 1)
  (setvar "osmode" osm)
  (princ)
)
;;;------------------------------------=------------------------------
;;;===================================================================
;;;***** END *****;;;