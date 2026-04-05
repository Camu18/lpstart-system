  %mouse=1
  $include "stdio.h"
  $include "win_man.h"
  $include "dbinput.h"
cls
input "Souse File Name      :",s$
input "Record Length        :",rl%
input "Begin Record         :",brno
input "Number of Records    :",num%
input "Destination File Name:",d$
input "Begin Record         :",bnum
open "R",1,s$,rl%
field 1,rl% as f1$
open "R",2,d$,rl%
field 2,rl% as f2$
brno=brno-1
bnum=bnum-1
for rno=1 to num%
   locate 20,1
   print rno
   get 1,rno+brno
   lset f2$=f1$
   put 2,rno+bnum
next rno
close
end
