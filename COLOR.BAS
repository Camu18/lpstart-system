$include "mhdr.bas"
mdefaction% 01,01,24,80,%enter
dim t$(15),co%(15)
t$(00)="Display Protected":t$(01)="Display unProtected":t$(02)="Choose"
t$(03)="Mark":t$(04)="Input":t$(05)="Windows":t$(06)="Header"
t$(07)="Color":t$(08)="Time":t$(09)="Search":t$(10)="CIA":t$(11)="Delete"
t$(12)="Insert":t$(13)="Recplay":t$(14)="Begin":t$(15)="End"
for t%=00 to 15
    co%(t%)=cx%(100+t%)
next t%

openwindow 05,02,18,20,cx%(100),02,00
   fd$="O" : colo%=00
   for row%=06 to 21
        for col%=04 to 19
           printf row%,col%,fd$,colo%
           incr colo%
        next col%
   next row%

openwindow 05,24,18,30,cx%(100),02,00
   for row%=06 to 21
       printf row%,28,t$(row%-6),co%(row%-6)
   next row%

chs%=00 : printf chs%+6,25,"->",cx%(102)

lrow%=06 : lcol%=04 : row%=06 : col%=04

printf 22,24," ESC Programm End  !Thank You!",cx%(101)

DO
  locate lrow%,lcol%,1
  x%=mkinp(1)
 if mlpress then
     mgetpos mrow%,mcol%
     if mrow%>=06 and mrow%<=21 then
        if mcol%>=25 and mcol%<=54 then
           row%=mrow% : col%=mcol%
           printf chs%+6,25,space$(2),cx%(100)
           printf mrow%,25,"->",cx%(102)
           chs%=mrow%-6
        else
           if mcol%>=04 and mcol%<=19 then
              lrow%=mrow% : lcol%=mcol%
              co%(chs%)=16*(mrow%-6)+(mcol%-4)
              printf chs%+6,28,t$(chs%),co%(chs%)
           end if
        end if
     end if
  else
   select case lastkeyx
   case %ESC
        exit loop
   case %DOWN
        incr row%
        if row%>=21 then row%=06
           printf chs%+6,25,space$(2),cx%(100)
           printf row%,25,"->",cx%(102)
           chs%=row%-6
   case %UP
        decr row%
        if row%<06 then row%=21
        printf chs%+6,25,space$(2),cx%(100)
        printf row%,25,"->",cx%(102)
        chs%=row%-6
   case %PGUP
        decr lrow%
        if lrow%<06 then lrow%=21
   case %PGDN
        incr lrow%
        if lrow%>21 then lrow%=06
   case %RIGHT
        incr lcol%
        if lcol%>19 then incr lrow% : lcol%=04
   case %LEFT
        decr lcol%
        if lcol%<04 then decr lrow% : lcol%=19
   case %ENTER
        co%(chs%)=16*(lrow%-6)+(lcol%-4)
        printf chs%+6,28,t$(chs%),co%(chs%)
   end select
   end if
loop

fd$=""
for t%=00 to 15
    fd$=fd$+chr$(co%(t%))
    cx%(t%+100)=co%(t%)
next t%
    lset fc$(chp%)=fd$
    put chp%,1
closewindow
closewindow
cls
locate 11,40 : goto pend
rem goto LPEND
WDTIM:
     if date$<>datum$ then
        printf 5,12,date$,cx%(101)
        datum$=date$
     end if
     printf 5,24,time$,cx%(101)
     return