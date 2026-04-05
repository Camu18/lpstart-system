$include "MHDR.bas"
get chp%,cp%(chp%) : fd$(15)=fc$(chp%)
frow%=asc(mid$(fc$(chp%),125,1))
fcol%=asc(mid$(fc$(chp%),126,1))  : bno%=cvi(mid$(fc$(chp%),127,2))
wnd%=cvl(mid$(cm$(chp%),55,4))
gosub MWDOW
gosub WCHSE
closewindow
if lastkeyx=%ESC then cl&(1)=00:goto pend
if lastkeyx=%F8 then
        closewindow : cp%(00)=1
        cp%(chp%)=val(command$) : if cp%(chp%)<1 then cp%(chp%)=1308
        get chp%,cp%(chp%) : cm$(chp%)=fc$(chp%)
        fld$=rtrim$(mid$(cm$(chp%),01,08))
        chain fld$
    end if

if lastkeyx=%enter then
       wnd%=wnd%+2 : gosub mgetkf
       get chp%,px%(frow%+fcol%*wx%(11)*wx%(12))
       x$=ucase$(rtrim$(mid$(fc$(chp%),1,08)))
       if x$="" then goto pend
       incr cp%(0) : cp%(cp%(0))=px%(frow%) : cm$(1)=fc$(chp%)
       mid$(fd$(15),125,4)=chr$(frow%)+chr$(fcol%)+mki$(bno%)
       lset fc$(chp%)=fd$(15) : put chp%,cp%(chp%)
       chain x$
end if
close
end
$include "lwnd.bas"