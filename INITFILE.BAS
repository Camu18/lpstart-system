$include "mhdr.bas"
wx%(0)=04 : wx%(1)=20 : wx%(2)=07 : wx%(3)=50 : wx%(4)=cx%(100) : wx%(5)=02
wx%(6)=00 : wx%(7)=10 : wx%(10)=07 : wx%(11)=7 : wx%(12)=1

dto%(0)=12:dto%(1)=12:dto%(2)=12:dto%(3)=12:dto%(4)=12:dto%(5)=12:dto%(6)=12

row%(0)=0:row%(1)=1:row%(2)=2:row%(3)=3:row%(4)=4:row%(5)=5:row%(6)=6

col%(0)=23:col%(1)=23:col%(2)=23:col%(3)=23:col%(4)=23:col%(5)=23:col%(6)=23

mxr%=6

cls
gosub WNDHD
wt%=0
gosub IPWND
if lastkeyx=%ESC then goto pend
gosub INFIL
goto lpend

WNDHD:
  openwindow wx%(0),wx%(1),wx%(2)+wx%(11)*wx%(12),wx%(3),wx%(4),wx%(5),wx%(6)
  printf wx%(0)+1,wx%(1)+3,"FILE INITIALISATION",wx%(4)
  printf wx%(0)+2,wx%(1)+1,string$(48,"="),&h87
  printf wx%(10)+0,wx%(1)+2,"File name..........:",wx%(4)
  printf wx%(10)+1,wx%(1)+2,"Reclen of File.....:",wx%(4)
  printf wx%(10)+2,wx%(1)+2,"From Record Number.:",wx%(4)
  printf wx%(10)+3,wx%(1)+2,"To   Record Number.:",wx%(4)
  printf wx%(10)+4,wx%(1)+2,"Init ASCII Value...:",wx%(4)
  printf wx%(10)+5,wx%(1)+2,"Record-Position....:",wx%(4)
  printf wx%(10)+6,wx%(1)+2,"Data Length........:",wx%(4)
 return

INFIL:
      x0$=rtrim$(screenstr$(wx%(10)+row%(0),wx%(1)+col%(0),dto%(0)))
      x1%=val(rtrim$(screenstr$(wx%(10)+row%(1),wx%(1)+col%(1),dto%(1))))
      x2%=val(rtrim$(screenstr$(wx%(10)+row%(2),wx%(1)+col%(2),dto%(2))))
      x3%=val(rtrim$(screenstr$(wx%(10)+row%(3),wx%(1)+col%(3),dto%(3))))
      x4%=val(rtrim$(screenstr$(wx%(10)+row%(4),wx%(1)+col%(4),dto%(4))))
      x5%=val(rtrim$(screenstr$(wx%(10)+row%(5),wx%(1)+col%(5),dto%(5))))
      x6%=val(rtrim$(screenstr$(wx%(10)+row%(6),wx%(1)+col%(6),dto%(6))))
 open "r",15,x0$,x1%
 field 15,x1% as fc$(15)
    for t%=x2% to x3%
        locate 3,20
        print t%
        get 15,t%
          fld$=fc$(15)
          mid$(fld$,x5%,x6%)=string$(x6%,x4%)
          lset fc$(15)=fld$
          put 15,t%
    next t%
    close 15
  return
WDTIM:
  return

IPWND:
 DO
    lx$=screenstr$(wx%(10)+row%(wt%),wx%(1)+col%(wt%),dto%(wt%))
    dbinp wx%(10)+row%(wt%),wx%(1)+col%(wt%),lx$,%c,dto%(wt%),0
    select case lastkeyx
    case %enter
          incr wt%
          if wt%>mxr% then exit
    case %ESC
         exit loop
    case %UP
         decr wt%:if wt%<0 then wt%=0
    case %DOWN
         incr wt%:if wt%>mxr% then wt%=mxr%
    end select
 LOOP
    return

