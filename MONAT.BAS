$include "mhdr.bas"
wnd%=cvl(mid$(cm$(chp%),55,4))
wno%=1 : gosub MWIND
openwindow 10,29,3,33,cx%(106),2,0
printf2 11,31,"!Bitte PIN eingeben",112,116
dbinp 11,52,fd$(16),%c,7,0
get chp%,1300
if ucase$(fd$(16))=ucase$(mid$(fc$(chp%),36,7)) then
   closewindow:wt%=0:gosub mreadi :gosub ipwnd:
else
   closewindow
end if
closewindow : locate 15,40 : goto pend
$include "mwnd.bas"
$include "msub.bas"
$include "index.bas"

IPWND:
 DO
    locate row%,col%,1 : x%=mkinp(1)
    select case lastkeyx
    case %F7
        fd$(15)=space$(1024)
        for i%=1 to 100
          get chu%,i%:lset fc$(chu%)=fd$(15)
          put chu%,i%
        next i%
    case %F9
         ex%=0
         for i%=1 to 31
           get chu%,ofs%(chu%)+i%
           width lprint 255 : lprint mid$(fc$(chu%),1,10)
           for t%=0 to cvi(mid$(fc$(chu%),11,2))
             if mid$(fc$(chu%),13+13*t%,4)="****" then exit for
             pv#(4)=cvs(mid$(fc$(chu%),13+13*t%,4))
             pv#(1)=cvs(mid$(fc$(chu%),17+13*t%,4)):pv#(5)=pv#(5)+pv#(1)
             pv#(2)=cvs(mid$(fc$(chu%),21+13*t%,4)):pv#(6)=pv#(6)+pv#(2)
             ac$=string$(8,"#")
             mid$(ac$,6,1)="."
             ad$=using$(ac$,pv#(1))
             ae$=using$(ac$,pv#(2))
             get chk%,ofs%(chk%)+pv#(4)
             bb$=mid$(fc$(chk%),74,15)+mid$(fc$(chk%),98,32)
             lprint bb$
             bc$=mid$(fc$(chk%),33,32)+"   - SUMME:"+ad$+"    - MWST:"+ae$
             lprint bc$
             pv#(1)=0:pv#(2)=0:ad$="":ae$=""
           next t%
         next i%
         ad$=using$(ac$,pv#(5)):ae$=using$(ac$,pv#(6))
         be$=  date$+"     Monat SUMME:"+ad$+" - Monat MWST:"+ae$
         lprint be$
         fd$(15)=string$(len(fc$(chu%)),0)
         for t%=1 to 43
             get chu%,ofs%(chu%)+t%:lset fc$(chu%)=fd$(15)
             put chu%,ofs%(chu%)+t%
         next t%
    case %CF9
         for t%=1 to 25
           x$=screenstr(t%,1,78)
           lprint x$
         next t%
    case %F10
         fd$(15)=space$(1024)
         for t%=1 to 43
            get chu%,ofs%(chu%)+t%:lset fc$(chu%)=fd$(15)
            put chu%,ofs%(chu%)+t%
         next t%
    case %enter
          wt%=0:gosub mreadi
          get chu%,50+val(rtrim$(screenstr(row%,dcp%,dto%)))
          wt%=01
          pv#(5)=0:pv#(6)=0
          for t%=1 to 31
          gosub mreadi
          md%(3)=00:pv#=0:day%=0:md%(1)=0:md%(0)=0:md4=0:md%(2)=0
          md%(0)=val(mid$(fc$(chu%),7+20*(t%-1),4))-2000
          md%(1)=md%(0) mod 4 : md4=(md%(0)-md%(1))/4*1461
          md4=md4+cx%(231+(12*md%(1)+val(mid$(fc$(chu%),1+20*(t%-1),2))-1))
          md4=md4+val(mid$(fc$(chu%),4+20*(t%-1),2))
          day%=md4 mod 7
          if day%=1 then x$="Samtag"+space$(3)
          if day%=2 then x$="Sonntag"+space$(2)
          if day%=3 then x$="Montag" +space$(3)
          if day%=4 then x$="Dientag"+space$(2)
          if day%=5 then x$="Mittwoch"+space$(1)
          if day%=6 then x$="Donnertag"
          if day%=0 then x$="Freitag"+space$(2)
          x$=mid$(fc$(chu%),4+20*(t%-1),2)+"-"+x$
          pv#=cvs(mid$(fc$(chu%),12+20*(t%-1),4)):pv#(5)=pv#(5)+pv#
          fd$(12)=string$(10,"#") : mid$(fd$(12),8,1)="."
          fd$(11)=using$(fd$(12),pv#)
          x$=x$+"-"+fd$(11)
          pv#=cvs(mid$(fc$(chu%),16+20*(t%-1),4)):pv#(6)=pv#(6)+pv#
          fd$(11)=using$(fd$(12),pv#)
          x$=x$+"-"+fd$(11)
          if t%<=16 then
            printf row%+t%-1,dcp%,x$,cx%(104)
          else
            printf row%+t%-17,dcp%+42,x$,cx%(104)
          end if
          x$=""
        next t%
         fd$(11)=using$(fd$(12),pv#(5)) :x$="M.Summe:"+fd$(11)
         fd$(11)=using$(fd$(12),pv#(6)) :x$=x$+"  -M.MWst:"+fd$(11)
         printf row%+t%-17,dcp%+38,x$,cx%(106)
    case %ESC
         exit
   case %left
         decr col% : if col%<dcp% then col%=dcp%
    case %right
         incr col% :if col%>dcp%+dto%-1 then col%=dcp%+dto%-1
    case %DEL
         fd$(20)=screenstr$(row%,col%+1,dcp%+dto%-col%-1)+space$(1)
         printf row%,col%,fd$(20),cx%(104)
    case %INSERT
         bit toggle flag%,0
    case ELSE
         if bit(flag%,0)=0 then
            printf row%,col%,chr$(lastkey),cx%(104) : incr col%
            if col%>dcp%+dto%-1 then col%=dcp%+dto%-1
         else
            fd$(20)=screenstr$(row%,dcp%,dto%)
            fd$(20)=left$(fd$(20),col%-dcp%)+chr$(lastkey)+mid$_
                             (fd$(20),col%-dcp%+1,dcp%+dto%-col%-1)
            incr col%
            if col%>dcp%+dto%-1 then col%=dcp%+dto%-1
            printf row%,dcp%,fd$(20),cx%(104)
          end if
    end select
 LOOP
    return

