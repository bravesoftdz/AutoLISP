;; dq.LSP
;; ��Ȩ���� (C) 2000-2002  ����ͨ��  
;;
;; ����ͨ����վ  http://www.mjtd.com
;; ���ߣ�֣����  mccad@mjtd.com
;;
;;   ��������ѿɹ������κ���;����Ŀ������޸ļ�����, ������ѭ����ԭ��:
;;
;;   1)  ���еİ�Ȩͨ����������ÿһ�ݿ����
;;   2)  ��ص�˵���ĵ�Ҳ�������а�Ȩͨ�漰��������ͨ�档
;;
;;   ���������ṩ��ΪӦ���ϵĲο�, ��δ�����������κα�֤; �����κ�����
;;   ��;֮��Ӧ��, �Լ���ҵ���������������ı�֤, �ڴ�һ�����Է��ϡ�
;;
;;�������ƣ�����ˮƽ�������
;;ִ�����dq
;;�����ܣ���ѡ���Ķ�������롢�Ҷ������С�
;;
;;
(defun c:dq (/ selobjs oldcmdecho)
  (setq oldcmdecho (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (setq selobjs (ssget))
  (if (or (not selobjs) (= (sslength selobjs) 1))
    (princ "\n�����ѡ���������������ϵĶ���")
    (process selobjs)
  )
  (setvar "cmdecho" oldcmdecho)
  (princ)
)
(defun process (selobjs	  /	    amode     apnt	apnt_x
		apnt_y	  count	    objname   vlaxobj	MinPoint
		MaxPoint  minext   maxext   ext_l	ext_r
		ext_m	  tpnt
	       )
  (initget "L M R")
  (setq	amode (getkword
		"\nѡ����뷽ʽ[�����(L)/����(M)/�Ҷ���(R)]<�����>:"
	      )
  )
  (if (not amode)
    (setq amode "L")
  )
  (initget 1)
  (setq apnt (getpoint "\nѡ��ˮƽ���뷽��Ķ���㣺"))
  (setq	apnt_x (car apnt)
	apnt_y (cadr apnt)
  )
  (vl-load-com)
  (setq count 0)
  (repeat (sslength selobjs)
    (setq objname (ssname selobjs count))
    (setq vlaxobj (vlax-ename->vla-object objname))
    (setq MinPoint (vlax-make-variant))
    (setq MaxPoint (vlax-make-variant))
    (vla-GetBoundingBox vlaxobj 'MinPoint 'MaxPoint)
    (setq minext (vlax-safearray->list MinPoint))
    (setq maxext (vlax-safearray->list MaxPoint))
    (setq ext_l (car minext))
    (setq ext_r (car maxext))
    (setq ext_m (+ (/ (abs (- ext_l ext_r)) 2) ext_l))
    (cond
      ((= amode "L")
       (setq tpnt (list ext_l apnt_y))
      )
      ((= amode "M")
       (setq tpnt (list ext_m apnt_y))
      )
      ((= amode "R")
       (setq tpnt (list ext_r apnt_y))
      )
    )
    (if	tpnt
      (command "_move" objname "" "non" tpnt "non" apnt)
    )
    (setq count (1+ count))
  )
)
(princ"\n�����������Ѽ��أ�����dq����ִ�С�----����ͨ��http://www.mjtd.com")

