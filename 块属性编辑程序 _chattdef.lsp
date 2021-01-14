;;;块属性编辑程序
;;;编写：HQD9639
;;;2003/6/9
(DEFUN DTR (DEG / )
  (* PI (/ DEG 180.0)))
;---------------------------------
(DEFUN RTD (RAD / )
  (/ (* 180.0 RAD) PI))
;-------------------------------
(defun c:chattdef ()
  (vl-load-com)
  (setq k T)
  (while k
            (setq  entbatt  (entsel "\n选取带属性图块: <退出>: "))
            (if  entbatt
                (progn
                      (setq entbatt (car  entbatt))                     
                     (setq wattvla (vlax-ename->vla-object entbatt))   
                     (setq name1 (vla-get-objectname wattvla))
                     (if (= name1 "AcDbBlockReference")
                          (progn
                                (if (=  (vla-get-HasAttributes wattvla) :vlax-true)
                                    (progn
                                          (setq attlst  (vlax-safearray->list  (vlax-variant-value (vla-getattributes wattvla))))
                                          (initget  "Value Height Width Rotation Font Layer Color Exit")
                                          (setq x0  (getkword "\n[Value//Height/Width/Rotation/Font/Layer/Color/Exit] <Exit>: "))
                                          (cond ((eq x0 "Value")
                                                      (if (> (length attlst) 1)
                                                           (progn
                                                                (initget  "Single All")
                                                                (setq y0  (getkword "\n [单个改变(Single) /全部(All)]<All>: "))
                                                                (cond ((= y0 "Single")
                                                                            (setq mm 0)
                                                                            (repeat (length attlst)                                                                   
                                                                                       (setq ent  (nth mm attlst))
                                                                                       (setq enttxt  (vla-get-TextString ent)) 
                                                                                       (setq newstr (getstring (strcat  "\n请输入新属性值<"  enttxt  ">:")))
                                                                                       (if (eq ""  newstr) (setq newstr enttxt))                                              
                                                                                       (vla-put-TextString ent newstr )
                                                                                       (setq mm (1+ mm))
                                                                            ) 
                                                                          )
                                                                          ((= y0 "All")                                                                         
                                                                            (setq newstr (getstring "\n请输入新属性值:")) 
                                                                            (foreach n attlst  (vla-put-TextString n newstr )) 
                                                                         )
                                                                 );cond
                                                           )
                                                           (progn
                                                                (setq newstr (getstring "\n请输入新属性值:")) 
                                                                (foreach n attlst  (vla-put-TextString n newstr ))
                                                           )
                                                      );if
                                                    )
                                                    ((eq x0 "Height")
                                                      (if (> (length attlst) 1)
                                                           (progn
                                                                (initget  "Single All")
                                                                (setq y0  (getkword "\n [单个改变(Single) /全部(All)]<All>: "))
                                                                 (if (not y0) (setq y0 "All"))
                                                                (cond ((= y0 "Single")
                                                                            (setq mm 0)
                                                                            (repeat (length attlst)                                                                   
                                                                                       (setq ent  (nth mm attlst))
                                                                                       (setq enttxt  (vla-get-TextString ent)) 
                                                                                       (setq enthei  (vla-get-Height ent)) 
                                                                                       (initget 4)                                                                                      
                                                                                       (setq newstr (getreal (strcat  "\n请输入属性{ " enttxt  " }新高度<"   (rtos enthei)  ">:")))
                                                                                       (if (not newstr) (setq newstr enthei))
                                                                                       (vla-put-Height ent newstr )
                                                                                       (setq mm (1+ mm))
                                                                            ) 
                                                                          )
                                                                          ((= y0 "All")                                                                         
                                                                            (initget 5)                                                                                      
                                                                            (setq newstr (getreal (strcat  "\n请输入属性新高度: ")))                                      
                                                                            (foreach n attlst  (vla-put-Height n newstr )) 
                                                                         )
                                                                 );cond
                                                           )
                                                           (progn
                                                                    (initget 5)                                                                                      
                                                                    (setq newstr (getreal (strcat  "\n请输入属性新高度: ")))                                      
                                                                    (foreach n attlst  (vla-put-Height n newstr )) 
                                                           )
                                                      );if
                                                    )
                                                    ((eq x0 "Width")
                                                      (if (> (length attlst) 1)
                                                           (progn
                                                                (initget  "Single All")
                                                                (setq y0  (getkword "\n [单个改变(Single) /全部(All)]<All>: "))
                                                                 (if (not y0) (setq y0 "All"))
                                                                (cond ((= y0 "Single")
                                                                            (setq mm 0)
                                                                            (repeat (length attlst)                                                                   
                                                                                       (setq ent  (nth mm attlst))
                                                                                       (setq enttxt  (vla-get-TextString ent)) 
                                                                                       (setq entwei  (vla-get-ScaleFactor ent)) 
                                                                                       (initget 4)                                                                                      
                                                                                       (setq newstr (getreal (strcat  "\n请输入属性{ " enttxt  " }新宽度<"   (rtos entwei)  ">:")))
                                                                                       (if (not newstr) (setq newstr entwei))
                                                                                       (vla-put-ScaleFactor ent newstr )
                                                                                       (setq mm (1+ mm))
                                                                            ) 
                                                                          )
                                                                          ((= y0 "All")                                                                         
                                                                            (initget 7)                                                                                      
                                                                            (setq newstr (getreal "\n请输入属性新宽度: "))                                  
                                                                            (foreach n attlst  (vla-put-ScaleFactor n newstr )) 
                                                                         )
                                                                 );cond
                                                           )
                                                           (progn
                                                                    (initget 7)                                                                                      
                                                                    (setq newstr (getreal "\n请输入属性新宽度: "))                                    
                                                                    (foreach n attlst  (vla-put-ScaleFactor n newstr )) 
                                                           )
                                                      );if
                                                    )
                                                    ((eq x0 "Rotation")
                                                      (if (> (length attlst) 1)
                                                           (progn
                                                                (initget  "Single All")
                                                                (setq y0  (getkword "\n [单个改变(Single) /全部(All)]<All>: "))
                                                                 (if (not y0) (setq y0 "All"))
                                                                (cond ((= y0 "Single")
                                                                            (setq mm 0)
                                                                            (repeat (length attlst)                                                                   
                                                                                       (setq ent  (nth mm attlst))
                                                                                       (setq enttxt  (vla-get-TextString ent)) 
                                                                                       (setq entrot  (vla-get-Rotation ent)) 
                                                                                       (setq entrot0  (rtd (vla-get-Rotation ent))) 
                                                                                       (setq newstr (getangle (strcat  "\n请输入属性{ " enttxt  " }新旋转角度<"   (rtos entrot0)  ">:")))
                                                                                       (if (not newstr) (setq newstr entrot))
                                                                                       (vla-put-Rotation ent newstr )
                                                                                       (setq mm (1+ mm))
                                                                            ) 
                                                                          )
                                                                          ((= y0 "All")                                                                         
                                                                            (initget 1)                                                                                      
                                                                            (setq newstr (getangle "\n请输入属性新转角度: "))                                   
                                                                            (foreach n attlst  (vla-put-Rotation n newstr )) 
                                                                         )
                                                                 );cond
                                                           )
                                                           (progn
                                                                    (initget 1)                                                                                      
                                                                    (setq newstr (getangle "\n请输入属性新转角度: "))                                     
                                                                    (foreach n attlst  (vla-put-Rotation n newstr )) 
                                                           )
                                                      );if
                                                    )
                                                    ((eq x0 "Font")
                                                      (if (> (length attlst) 1)
                                                           (progn
                                                                (initget  "Single All")
                                                                (setq y0  (getkword "\n [单个改变(Single) /全部(All)]<All>: "))
                                                                (if (not y0) (setq y0 "All"))
                                                                (cond ((= y0 "Single")
                                                                            (setq mm 0)
                                                                            (repeat (length attlst)                                                                   
                                                                                       (setq ent  (nth mm attlst))
                                                                                       (setq enttxt  (vla-get-TextString ent)) 
                                                                                       (setq entsty  (vla-get-StyleName ent)) 
                                                                                       (setq newstr (getstring (strcat  "\n请输入属性{ " enttxt " }新字型<"  entsty  ">:")))
                                                                                       (if (eq ""  newstr) (setq newstr entsty))                                              
                                                                                       (vla-put-StyleName ent newstr )
                                                                                       (setq mm (1+ mm))
                                                                            ) 
                                                                          )
                                                                          ((= y0 "All") 
                                                                            (initget 1)                                                                     
                                                                            (setq newstr (getstring "\n请输入属性新字型<Standard>:")) 
                                                                            (if (eq "" newstr) (setq newstr "Standard"))
                                                                            (foreach n attlst  (vla-put-StyleName n newstr )) 
                                                                         )
                                                                 );cond
                                                           )
                                                           (progn
                                                                (setq newstr (getstring "\n请输入属性新字型<Standard>:")) 
                                                                (if (eq "" newstr) (setq newstr "Standard"))
                                                                (foreach n attlst  (vla-put-StyleName n newstr ))
                                                           )
                                                      );if
                                                    )
;;---------------------------------------------------------------------------------------------------------------------------------
                                                    ((eq x0 "Layer")
                                                      (if (> (length attlst) 1)
                                                           (progn
                                                                (initget  "Single All")
                                                                (setq y0  (getkword "\n [单个改变(Single) /全部(All)]<All>: "))
                                                                (if (not y0) (setq y0 "All"))
                                                                (cond ((= y0 "Single")
                                                                            (setq mm 0)
                                                                            (repeat (length attlst)                                                                   
                                                                                       (setq ent  (nth mm attlst))
                                                                                       (setq enttxt  (vla-get-TextString ent)) 
                                                                                       (setq entlay  (vla-get-Layer ent)) 
                                                                                       (setq newstr (getstring (strcat  "\n请输入属性{ " enttxt " }所在新层<"  entlay  ">:")))
                                                                                       (if (eq ""  newstr) (setq newstr entlay))                                              
                                                                                       (vla-put-Layer ent newstr )
                                                                                       (setq mm (1+ mm))
                                                                            ) 
                                                                          )
                                                                          ((= y0 "All") 
                                                                            (setq newstr (getstring "\n请输入属性所在新层<0>:")) 
                                                                            (if (eq "" newstr) (setq newstr "0"))
                                                                            (foreach n attlst  (vla-put-Layer n newstr )) 
                                                                         )
                                                                 );cond
                                                           )
                                                           (progn
                                                               (setq newstr (getstring "\n请输入属性所在新层<0>:")) 
                                                                (if (eq "" newstr) (setq newstr "0"))
                                                                (foreach n attlst  (vla-put-Layer n newstr ))
                                                           )
                                                      );if
                                                    )
;;---------------------------------------------------------------------------------------------------------------------------------
                                                    ((eq x0 "Color")
                                                      (if (> (length attlst) 1)
                                                           (progn
                                                                (initget  "Single All")
                                                                (setq y0  (getkword "\n [单个改变(Single) /全部(All)]<All>: "))
                                                                (if (not y0) (setq y0 "All"))
                                                                (cond ((= y0 "Single")
                                                                            (setq mm 0)
                                                                            (repeat (length attlst)                                                                   
                                                                                       (setq ent  (nth mm attlst))
                                                                                       (setq enttxt  (vla-get-TextString ent)) 
                                                                                       (setq entcor (vla-get-Color ent))
                                                                                       (setq k1 T)
                                                                                       (while k1
                                                                                              (initget 4)                                                                                      
                                                                                              (setq newstr (getint (strcat  "\n请输入属性{ " enttxt  " }新颜色<"   (itoa entcor)  ">:")))
                                                                                              (if ( or (and (>= newstr 0) (<= newstr 256)) (eq nil newstr))
                                                                                                   (setq k1 nil) 
                                                                                               )
                                                                                       )             
                                                                                       (if (not newstr) (setq newstr entcor))                                              
                                                                                       (vla-put-Color ent newstr )
                                                                                       (setq mm (1+ mm))
                                                                            ) 
                                                                          )
                                                                          ((= y0 "All")
                                                                            (setq k1 T)
                                                                            (while k1
                                                                                      (initget 5)                                                                                      
                                                                                      (setq newstr (getint  "\n请输入属性新颜色: "))
                                                                                      (if (and (>= newstr 0) (<= newstr 256)) 
                                                                                                (setq k1 nil)
                                                                                        )
                                                                           )
                                                                            (foreach n attlst  (vla-put-Color n newstr )) 
                                                                         )
                                                                 );cond
                                                           )
                                                           (progn
                                                                    (setq k1 T)
                                                                     (while k1
                                                                                      (initget 5)                                                                                      
                                                                                      (setq newstr (getint  "\n请输入属性新颜色: "))
                                                                                      (if (and (>= newstr 0) (<= newstr 256)) 
                                                                                                (setq k1 nil) 
                                                                                       )
                                                                  )
                                                                   (foreach n attlst  (vla-put-Color n newstr )) 
                                                           )
                                                      );if
                                                    )
                                                    (T (setq k nil))
                                         );cond                                    
                                    );progn
                               ) ;if                
                          );progn
                     );if
               );progn
               (setq k nil)
         );if
  );while
  (princ)
);end
