$include "mhdr.bas"
wnd%=cvl(mid$(cm$(chp%),55,4))
wno%=1 : gosub MWIND
mns%=ofs%(cha%) : daf%=cha%
get chp%,1010 : last&=cvl(mid$(fc$(chp%),40,4)) : incr last&
wt%=0 : gosub mreadh
DO
     gosub mreadi
     if ddb%=11 then printf row%,col%,using$("#####",last&),cx%(101)
     if dpl% then incr wt% : iterate
     gosub mkyb : if lastkeyx=%ESC then exit
     if bit(flg&(2),0) and ddb%<>10 and lastkeyx<>%F3 and bit(flg&(0),1)<>1_
                                          then gosub PUTWIND
     if lastkeyx=%F6 then
       wnd%=wid%(2) : wno%=02 : gosub mwind : wt%=00 : gosub mreadh
       bit set flg&(0),0 : iterate
     end if
     if dky% and lastkeyx<>%F3 then
        gosub SEARCH
        if bit(flg&(1),0) then
           if bit(flg&(0),0) then closewindow : bit reset flg&(0),0
           gosub dspl : bit toggle flg&(1),0 : wt%=01 : iterate
        else
           if bit(flg&(0),0) then closewindow : bit reset flg&(0),0
           incr wt% : wno%=01 : gosub mreadh : bit set flg&(2),0 : iterate
        end if
     end if
' ---- egan -----------------------------------------
    for t%=00 to 4 : flg&(t%)=00 : next t%
    for wt%=01 to mxr%
       gosub mreadi : printf row%,dcp%,space$(dto%),cx%(100)
    next wt%  : wt%=00
LOOP
closewindow
goto PEND
$include "MWND.bas"
$include "MSUB.bas"
$include "MKYB.bas"
$include "index.bas"
$include "putwin.bas"

