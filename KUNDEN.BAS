$include "mhdr.bas"
wnd%=cvl(mid$(cm$(chp%),55,4))
wno%=1 : gosub MWIND
mns%=ofs%(chk%) : daf%=chk%
get chp%,1012 : last&=cvl(mid$(fc$(chp%),40,4)) :
if last&=cvl(mid$(fc$(chp%),36,4)) then
   beep
   openwindow 6,22,3,37,cx%(106),01,00
   printf  7,24,"Sie haben kein Kunden frei mehr!!",cx%(104)
   x%=mkinp(1): closewindow:closewindow:stop
end if
if last&>cvl(mid$(fc$(chp%),36,4))-30 then
   beep
   openwindow 6,22,3,37,cx%(106),01,00
   printf  7,24,"Sie haben nur:        Kunden frei",cx%(104)
   locate 7,40 : print cvl(mid$(fc$(chp%),36,4))-last&
   x%=mkinp(1)
   closewindow
end if
incr last&
wt%=0 : gosub mreadh
DO
    gosub mreadi
    if ddb%=11 then printf row%,col%,using$("#####",last&),cx%(101)
    if dpl% then incr wt% : iterate
    if ddb%=01 and cl&(0)=01 then
       printf row%,dcp%,fc$(16),cx%(104):bit set flg&(2),0
       bit reset flg&(0),0 : wno%=01:incr wt%:gosub mreadh:iterate
    end if
    gosub mkyb
' --- search strasse ------------------------
    gosub strass
' -----------------------------------------------
    if lastkeyx=%ESC then exit
' ----- put -------------------------------------
    if bit(flg&(2),0) and ddb%<>10 and lastkeyx<>%F3 and bit(flg&(0),1)<>1_
                                          then gosub PUTWIND
' ---- search for record_Nr ----------------------
    if lastkeyx=%F5 then
       wnd%=wid%(4) : wno%=04 : gosub mwind : wt%=00 : gosub mreadh
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
        gosub dspl : bit toggle flg&(1),0 : wt%=01 : iterate
      else
        if bit(flg&(0),0) then closewindow : bit reset flg&(0),0
        incr wt% : wno%=01 : gosub mreadh : bit set flg&(2),0 : iterate
      end if
    end if
' ---- egan -----------------------------------------
    if cl&(0)=01 then
       closewindow : cp%(00)=1
       cp%(chp%)=val(command$) : if cp%(chp%)<1 then cp%(chp%)=1308
       get chp%,cp%(chp%) : cm$(chp%)=fc$(chp%)
       fld$=rtrim$(mid$(cm$(chp%),01,08))
       chain fld$
    end if
    for t%=00 to 4 : flg&(t%)=00 : next t%
    for wt%=01 to mxr%
       gosub mreadi : printf row%,dcp%,space$(dto%),cx%(100)
    next wt%  : wt%=00
LOOP
cl&(0)=0
closewindow : locate 09,30 : goto PEND
$include "MWND.bas"
$include "MSUB.bas"
$include "MKYB03.bas"
$include "index.bas"
$include "putwin.bas"
$include "indstr.bas"
