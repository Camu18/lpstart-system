$include "MHDR.bas"
cls
mdefaction 08,10,08,60,%enter
 %PLUS=20011
 %MINUS=18989
openwindow 08,20,09,40,cx%(100),02,00
printf 09,34,"WILLKOMMEN",cx%(100)
printf 10,27," DATUM             ZEIT ",cx%(100)
printf 14,29,"Mit +=Plus and -=Minus",cx%(100)
printf 15,22,"Mit ESC or ENTER Progend !Thank you!",cx%(100)
row%=12 : col%=22
DO
   locate row%,col%,0
   x%=mkinp(1)
   if mlpress then
      mgetpos row%,col%
      if col%>24 and col%<27 then td%=00 : gosub WDTIM
      if col%>27 and col%<30 then td%=01 : gosub WDTIM
      if col%>30 and col%<35 then td%=02 : gosub WDTIM
      if col%>43 and col%<46 then td%=03 : gosub WDTIM
      if col%>46 and col%<49 then td%=04 : gosub WDTIM
      if col%>49 and col%<52 then td%=05 : gosub WDTIM
   else
   select case lastkeyx
   case %PLUS
        if td%>2 then
            st%=val(mid$(time$,1,2))
            ph%=val(mid$(time$,4,2))
            sk%=val(mid$(time$,7,2))

            select case td%
            case 03
                 incr st% : if st%>23 then st%=00
            case 04
                 incr ph% : if ph%>59 then ph%=00
            case 05
                  incr sk% : if sk%>59 then sk%=00
            end select
            fd$=right$(str$(100+st%),2)+":"+right$(str$(100+ph%),2)+":"+_
                                           right$(str$(100+sk%),2)
            time$=fd$ : gosub WDTIM
        else
            mn%=val(mid$(date$,1,2))
            dd%=val(mid$(date$,4,2))
            jh%=val(mid$(date$,7,4))

            select case td%
            case 00 : rem - monat
                 incr mn% : if mn%>12 then mn%=01
            case 01 : rem - Tag
                 incr dd%
            case 02 : rem - Jahr
                 incr jh%
            end select
                 xx%=jh% mod 4 : cx%(282)=29
                 if xx%>0 then cx%(282)=28
                 if dd%>cx%(280+mn%) then dd%=01
            fd$=right$(str$(100+mn%),2)+"-"+right$(str$(100+dd%),2)+"-"+_
                                           right$(str$(10000+jh%),4)
            date$=fd$ : gosub WDTIM
        end if
   case %MINUS
        if td%>2 then
           st%=val(mid$(time$,1,2))
           ph%=val(mid$(time$,4,2))
           sk%=val(mid$(time$,7,2))

           select case td%
           case 03
                decr st% : if st%<00 then st%=23
           case 04
                decr ph% : if ph%<00 then ph%=59
           case 05
                decr sk% : if sk%<00 then sk%=59
           end select

           fd$=right$(str$(100+st%),2)+":"+right$(str$(100+ph%),2)+":"+_
                                          right$(str$(100+sk%),2)
           time$=fd$ : gosub WDTIM
         else
           mn%=val(mid$(date$,1,2))
           dd%=val(mid$(date$,4,2))
           jh%=val(mid$(date$,7,4))

           select case td%
           case 00
                decr mn% : if mn%<01 then mn%=12
           case 01
                decr dd%
           case 02
                decr jh%
           end select

           xx%=jh% mod 4 : mn%(2)=29
           if xx%>0 or jh%=1900 or jh%=2000 then mn%(2)=28
           if dd%<01 then dd%=cx%(280+mn%)
           fd$=right$(str$(100+mn%),2)+"-"+right$(str$(100+dd%),2)+"-"+_
                                          right$(str$(10000+jh%),4)
           date$=fd$ : gosub WDTIM
        end if
   case %ESC
        exit LOOP
   case %RIGHT
        incr td%
        if td%>05 then td%=00
        gosub WDTIM
   case %LEFT
        decr td%
        if td%<00 then td%=05
         gosub WDTIM
   case %ENTER
        exit loop
   end select
   end if
LOOP
closewindow : locate 09,40 : goto pend
WDTIM:
    printf 12,25,date$,cx%(102)
    printf 12,44,time$,cx%(102)

    if td%=00 then printf 12,25,mid$(date$,1,2),cx%(103)
    if td%=01 then printf 12,28,mid$(date$,4,2),cx%(103)
    if td%=02 then printf 12,31,mid$(date$,7,4),cx%(103)

    if td%=03 then printf 12,44,mid$(time$,1,2),cx%(103)
    if td%=04 then printf 12,47,mid$(time$,4,2),cx%(103)
    if td%=05 then printf 12,50,mid$(time$,7,2),cx%(103)
    return