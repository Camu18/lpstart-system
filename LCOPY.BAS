$include "mhdr.bas"
wx%(0)=04 :wx%(1)=20 : wx%(2)=08 : wx%(3)=40 : wx%(4)=cx%(100) : wx%(5)=02
wx%(6)=00 : wx%(10)=06 : wx%(11)=07 : wx%(12)=01
dto%(0)=15 : dto%(1)=15 : dto%(2)=15 : dto%(3)=15 : dto%(4)=15 : dto%(5)=15

row%(0)=3 : row%(1)=4 : row%(2)=5 : row%(3)=6 : row%(4)=9 : row%(5)=10
col%(0)=21 : col%(1)=21 : col%(2)=21 : col%(3)=21 : col%(4)=21 : col%(5)=21
mxr%=05

cls
gosub WNDHD
wt%=00
gosub IPWND
if lastkeyx=%ESC then goto PEND
gosub LCOPY
goto pend

WNDHD:
  openwindow wx%(0),wx%(1),wx%(2)+wx%(11)*wx%(12),wx%(3),wx%(4),wx%(5),wx%(6)
    printf wx%(10)-01,wx%(1)+10,"LCOPY",wx%(4)
    printf wx%(10)+00,wx%(1)+1,string$(38,"="),&h87
    printf wx%(10)+02,wx%(1)+2,"    Source File   ",&h97
    printf wx%(10)+03,wx%(1)+1," File Name.........:",wx%(4)
    printf wx%(10)+04,wx%(1)+1," Reclen of File....:",wx%(4)
    printf wx%(10)+05,wx%(1)+1," From Record Number:",wx%(4)
    printf wx%(10)+06,wx%(1)+1," To of Records.....:",wx%(4)
    printf wx%(10)+08,wx%(1)+2," Detination File.:",&h97
    printf wx%(10)+09,wx%(1)+1," File Name.........:",wx%(4)
    printf wx%(10)+10,wx%(1)+1," From Record Number:",wx%(4)
  return

LCOPY:
  x0$=rtrim$(screenstr$(wx%(10)+row%(0),wx%(1)+col%(0),dto%(0)))
  x1%=val(rtrim$(screenstr$(wx%(10)+row%(1),wx%(1)+col%(1),dto%(1))))
  x2%=val(rtrim$(screenstr$(wx%(10)+row%(2),wx%(1)+col%(2),dto%(2))))
  x3%=val(rtrim$(screenstr$(wx%(10)+row%(3),wx%(1)+col%(3),dto%(3))))
  x4$=rtrim$(screenstr$(wx%(10)+row%(4),wx%(1)+col%(4),dto%(4)))
  x5%=val(rtrim$(screenstr$(wx%(10)+row%(5),wx%(1)+col%(5),dto%(5))))
   open "R",13,x0$,x1%
   field 13,x1% as fc$(13)
   open "R",14,x4$,x1%
   field 14,x1% as fc$(14)
   decr x2%
   decr x5%
   for t%=1 to x3%
       locate 3,20
       print t%
       get 13,t%+x2%
       lset fc$(14)=fc$(13)
       put 14,t%+x5%
    next t%
   close 13
   close 14
  return
WDTIM:
  return
$include "WDINP.sav"