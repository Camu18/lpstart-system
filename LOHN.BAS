$include "mhdr.bas"
dim pr$(20)
wnd%=cvl(mid$(cm$(chp%),55,4))
wno%=1 : gosub MWIND
mns%=ofs%(chc%) : daf%=chc%
wt%=0 : gosub mreadh
DO
    gosub mreadi :  if dpl% then incr wt% : iterate
    if bit(flg&(0),1) then col%=dcp%+dto%-1
    gosub mkyb
    if bit(flg&(0),1) then incr mxr%
' -----------------------------------------------
    if lastkeyx=%ESC then locate 17,34 : exit
    if wt%=mxr% then gosub lastwt : iterate
    if lastkeyx=%F2 then gosub tlohn
    if lastkeyx=%F9 then gosub tlohn : gosub Drucker
' ---- search for record_Nr ----------------------
    if lastkeyx=%F5 then
       wnd%=wid%(3) : wno%=03 : gosub mwind : wt%=00 : gosub mreadh
       bit set flg&(0),0 : iterate
    end if
' ---- search for name --------------------------
    if lastkeyx=%F6 then
       wnd%=wid%(2) : wno%=02 : gosub mwind : wt%=00 : gosub mreadh
       bit set flg&(0),0 : iterate
    end if
' ----- search for tel ----------------------------
    if dky% and lastkeyx<>%F3 then
      gosub SEARCH
      if bit(flg&(1),0) then
        if bit(flg&(0),0) then closewindow : bit reset flg&(0),0
        gosub dspl : bit reset flg&(1),0 : wt%=18 : last&=kno& : iterate
      else
        if bit(flg&(0),0) then closewindow : bit reset flg&(0),0
        wno%=01 : gosub mreadh
      end if
    end if
' ---- egan -----------------------------------------
    for t%=00 to 4 : flg&(t%)=0 : next t%
    for wt%=00 to mxr%
       gosub mreadi : printf row%,dcp%,space$(dto%),cx%(100)
    next wt%  : wt%=00
LOOP
closewindow : goto PEND
$include "MWND.bas"
$include "MSUB.bas"
$include "MKYB.bas"
$include "index.bas"
DSPL:
     fd$(15)=fc$(chc%)
     wno%=01 : gosub mreadh : bit set flg&(0),1
     for wt%=00 to 17 : gosub mreadi : gosub mreads : gosub mreadp
     next wt% : decr mxr%
    return

LASTWT:
     pv#=00
     for wt%=dre% to mxr%
        gosub mreadi
        if wt%=mxr%-1 then
          pv#=pv#-val(screenstr$(row%,dcp%,dto%))
        else
          if wt%<>mxr% then
             pv#=pv#+val(screenstr$(row%,dcp%,dto%))
          else
             fd$(12)=string$(dto%,"#") : mid$(fd$(12),dto%-dsp%,1)="."
             fd$(11)=using$(fd$(12),pv#)
             printf row%,dcp%,fd$(11),cx%(104)
          end if
        end if
     next wt% : decr mxr% : wt%=mxr%
    return
TLOHN:
    wt%=mxr% : gosub mreadi
' --put tien lan cuoi------
     mid$(fd$(15),373,4)=mks$(pv#)
' --put tong so tien nhan----
     pv#(1)=cvs(mid$(fd$(15),dtp%,dtl%))
     pv#=pv#+pv#(1) : mid$(fd$(15),dtp%,dtl%)=mks$(pv#)
' --put ngay nhan tien lan cuoi------
     md%(3)=00
     if val(mid$(date$,7,2))<20 then
        md%(0)=val(right$(date$,4))-1900
     else
        md%(0)=val(right$(date$,4))-2000
     end if
     md%(1)=md%(0) mod 4 : md%(2)=(md%(0)-md%(1))/4
     for t4%=01 to val(left$(date$,2))
        incr md%(3),cx%(280+t4%)
     next t4%
     md4=val(mid$(date$,4,2))+md%(3)+md%(0)*365+md%(2) : pv#=md4
     mid$(fd$(15),232,4)=mks$(pv#)
     lset fc$(chc%)=fd$(15) : put chc%,ofs%(chc%)+last&
    return

DRUCKER:
       for t%=wx%(0) to wx%(10)+wx%(2)-2
          wd$(12)=screenstr$(t%,wx%(1)+1,wx%(3)-2) : lprint wd$(12)
       next t%
    return