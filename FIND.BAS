%mouse=0
$include "stdio.h"
$include "dbinput.h"
cls
printf 10,10,"FIND:",&h25
dbinp 10,15,y$,%c,30,&h23
fd$=ucase$(rtrim$(y$))
x$=dir$("*.bas")
while x$<>""
open "b",1,x$
x%=lof(1)
get$ 1,x%,f$
gd%=instr(1,ucase$(f$),fd$)
if gd%>0 then
   print x$
else
end if
close 1
x$=dir$
wend
