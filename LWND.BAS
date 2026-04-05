WCHSE:
  mdefaction wx%(0)+wx%(10),wx%(1)+1,wx%(11)*wx%(12),wx%(3)-2,%enter
  colo%=cx%(102) : gosub wdspl
  do
  x%=mkinp(1)
  if mlpress then
     mgetpos row%,col%
     if row%=frow%+wx%(10)+wx%(0) then
        exit loop
     else
      if row%>wx%(0)+wx%(10)+wx%(11)*wx%(12) or row%<wx%(10)+wx%(0) then
      else
         colo%=cx%(100) : gosub wdspl
         frow%=row%-wx%(10)-wx%(0)
         colo%=cx%(102) : gosub wdspl
      end if
     end if
  else
  select case lastkeyx
  case %up
      colo%=cx%(100) : gosub WDSPL
      frow%=frow%-1:if frow%<0 then frow%=wx%(11)*wx%(12)-1
      colo%=cx%(102) : gosub WDSPL
  case %down
      colo%=cx%(100) : gosub WDSPL
      incr frow% : if frow%>wx%(11)*wx%(12)-1 then frow%=0
      colo%=cx%(102) : gosub WDSPL
  case %pgdn
      if wx%(7)<wx%(11)*wx%(12)-1 then
      else
         if bno%<wx%(7) then

         incr bno%,wx%(11)*wx%(12)-1
            gosub dsmen
         colo%=cx%(102) : gosub wdspl
         else
         end if
      end if
  case %pgup
      if bno%<01 then
      else
        decr bno%,wx%(11)*wx%(12)-1
        gosub dsmen
        colo%=cx%(102) : gosub wdspl
     end if
  case %left
      colo%=cx%(100) : gosub WDSPL
      decr fcol%
      if fcol%<00 then fcol%=wx%(8)-1
      colo%=cx%(102) : gosub WDSPL
  case %right
      colo%=cx%(100) : gosub WDSPL
      incr fcol%
      if fcol%=wx%(8) then  fcol%=00
      colo%=cx%(102) : gosub WDSPL
  case %ESC
       if cl&(1)=50 then exit loop
  case %enter,%F8
      exit loop
  end select
  end if
  loop

WDSPL:
  x$=screenstr$(wx%(10)+wx%(0)+frow%,wx%(1)+1+(wx%(3)-2)/wx%(8)*fcol%,_
                                               (wx%(3)-2)/wx%(8))
  printf wx%(10)+wx%(0)+frow%,wx%(1)+1+(wx%(3)-2)/wx%(8)*fcol%,x$,colo%
  return

DSMEN:
   colo%=cx%(100)
   for t%=10 to wx%(11)*wx%(12)-1
       get chp%,wnd%+t%+1+bno%
       printf wx%(0)+t%,wx%(1)+1,left$(fc$(1),wx%(3)-2),colo%
   next t%
   return


MWDOW:
   wrn%=00   : rem - wie row% Bewegung
               rem - wnd%=zeile in windows.dat
   DO
     get chw%,wrn%+wnd%
     wd$(10)=ucase$(mid$(fc$(chw%),1,4))
     wd$(11)=ucase$(mid$(fc$(chw%),6,76))
     select case wd$(10)
     case "WIND"
           gosub MGETKF
           for t7%=0 to 8
               wx%(t7%)=px%(t7%)
           next t7%
     case "ROWS"
          wnd%=wnd%+wrn%
          gosub MGETKF
          for t7%=10 to 12
              wx%(t7%)=px%(t7%-10)
          next t7%
          wx%(4)=cx%(100)
          openwindow wx%(0),wx%(1),wx%(2)+wx%(11)*wx%(12),wx%(3),wx%(4),_
                                                             wx%(5),wx%(6)
          wnd%=wnd%-wrn%
     case "TEXT"
          for tm%=1 to wx%(10)-1
           get chw%,wnd%+wrn%+tm%
            printf wx%(0)+tm%,wx%(1)+1,mid$(fc$(chw%),1,wx%(3)-2),cx%(100)
          next tm%
          row%=00
          for tm%=1 to wx%(12)
           for tm1%=wx%(10) to wx%(10)+wx%(11)*wx%(12)-1
             get chw%,wnd%+wrn%+tm1%
             printf wx%(0)+tm1%+row%,wx%(1)+1,mid$(fc$(chw%),1,wx%(3)-2),_
                                                                  cx%(100)
           next tm1%
           incr row%,wx%(11)
          next tm%
          for tm%=wx%(10)+wx%(11)*wx%(12) to wx%(11)*wx%(12)+wx%(2)-2
           get chw%,wnd%+wrn%+tm%
            printf wx%(0)+tm%,wx%(1)+1,mid$(fc$(chw%),1,wx%(3)-2),cx%(100)
          next tm3%
     case "ENDE"
          exit loop
     end select
     incr wrn%
   LOOP
   return
WDTIM:
   return
$include "MSUB.bas"